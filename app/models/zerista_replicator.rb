class ZeristaReplicator

  def initialize(submission)
    @submission = submission
  end

  def replicate!
    if @submission.is_confirmed? && @submission.is_public?
      replicate_submission!
    else
      remove_submission!
    end

  end

  def replicate_submission!
    return unless @submission.start_day.present? && @submission.end_day.present? && @submission.start_hour.present? && @submission.end_hour.present?
    estimated_size = @submission.estimated_size.to_i
    attrs = {   name: @submission.title,
                description: process_into_html(@submission.description),
                start_time: date_for_slot(@submission.start_day) + @submission.start_hour.hours,
                end_time: date_for_slot(@submission.end_day) + @submission.end_hour.hours,
                client_id: @submission.id,
                track_id: @submission.track.zerista_track_id,
                tag_list: @submission.track.name,
                max_attendees: (estimated_size == 0 ? nil : estimated_size) }
    if @submission.venue
      attrs[:location_name] = @submission.venue.name
      # attrs[:address] = @submission.venue.address
      # attrs[:city] = @submission.venue.city
      # attrs[:state] = @submission.venue.state
      # attrs[:country] = 'US'
      attrs[:description] << process_into_html("\n  \nLocated at [#{@submission.venue.name} - #{@submission.venue.address}](http://maps.google.com/?q=#{@submission.venue.address_for_google_maps})")
    end
    # Try to create first
    result = client.create_event attrs
    # Otherwise update
    if result['error'] == 'Event with that client_id already exists.'
      client.update_event_by_client_id @submission.id, attrs
    end
  end

  def remove_submission!
    client.delete_event_by_client_id @submission.id
  end

  protected

  def date_for_slot(day)
    case day
    when 'Monday'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-16')
    when 'Tuesday'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-17')
    when 'Wednesday'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-18')
    when 'Thursday'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-19')
    when 'Friday'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-20')
    when 'Weekend before'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-15')
    when 'Weekend after'
      ActiveSupport::TimeZone['America/Denver'].parse('2013-9-21')
    end
  end

  def process_into_html(content)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ]
    result = pipeline.call content
    result[:output]
  end

  def client
    @client ||= Zerista::Client.new(ENV['ZERISTA_SUBDOMAIN'], ENV['ZERISTA_KEY_ID'], ENV['ZERISTA_SIGNING_KEY'])
  end

end
