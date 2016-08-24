module ScheduleHelper

  def formatted_start_date_for_index(index, format = '%B %-d')
    (Submission::WEEK_START + index.days - 2.days).strftime(format)
  end

  def registered_for_session?(submission)
    registered? && current_registration.submission_ids.include?(submission.id)
  end

end
