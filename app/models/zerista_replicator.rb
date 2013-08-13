class ZeristaReplicator

  def initialize(submission)
    @submission = submission
  end

  def replicate!
    return unless @submission.day && @submission.time_range
    client.create_event @submission.title,
                        @submission.description,
                        date_for_slot + offset_for_slot,
                        date_for_slot + offset_for_slot + 2.hours,
                        @submission.id,
                        @submission.track.zerista_track_id
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

  def client
    @client ||= Zerista::Client.new(ENV['ZERISTA_SUBDOMAIN'], ENV['ZERISTA_KEY_ID'], ENV['ZERISTA_SIGNING_KEY'])
  end

end
