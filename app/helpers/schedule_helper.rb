module ScheduleHelper

  def formatted_start_date_for_index(index, format = '%B %-d')
    (EventSchedule::WEEK_START_DATE + index.days - 2.days).strftime(format)
  end

  def registered_for_session?(submission)
    registered? && current_registration.submission_ids.include?(submission.id)
  end

  def json_for_map(submissions)
    list = submissions.where('venue_id IS NOT NULL').map do |s|
      puts s.venue.combined_address
      { title: s.title,
        link: schedule_url(s),
        venue_name: s.venue.name,
        address: s.venue.address_for_google_maps }
    end
    JSON.generate(list)
  end
end
