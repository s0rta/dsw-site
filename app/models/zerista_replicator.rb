class ZeristaReplicator

  def initialize(submission)
    @submission = submission
  end

  def replicate!
    if @submission.is_confirmed?
      replicate_submission!
    else
      remove_submission!
    end

  end

  def replicate_submission!
    return unless @submission.day.present? && @submission.time_range.present?
    attrs = {   name: @submission.title,
                description: process_into_html(@submission.description),
                start_time: date_for_slot + offset_for_slot,
                end_time: date_for_slot + offset_for_slot + 2.hours,
                client_id: @submission.id,
                track_id: @submission.track.zerista_track_id }
    if @submission.venue
      attrs[:location_name] = @submission.venue.name
      attrs[:address] = @submission.venue.address
      attrs[:city] = @submission.venue.city
      attrs[:state] = @submission.venue.state
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

  def date_for_slot
    case @submission.day
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

  def offset_for_slot
    case @submission.time_range
    when 'Breakfast'
      8.hours
    when 'Early morning'
      9.hours
    when 'Morning'
      11.hours
    when 'Lunch'
      12.hours
    when 'Early afternoon'
      13.hours
    when 'Afternoon'
      15.hours
    when 'Happy hour'
      17.hours
    when 'Evening'
      18.hours
    when 'Late night'
      22.hours
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
