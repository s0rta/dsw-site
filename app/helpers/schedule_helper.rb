module ScheduleHelper

  def formatted_start_date_for_index(index, year, format = '%B %-d')
    (AnnualSchedule.find_by!(year: year).week_start_at + index - 2).strftime(format)
  end

  def registered_for_session?(submission)
    registered? && current_registration.submission_ids.include?(submission.id)
  end

  def ratings_for_select
    { '5' => 'Outstanding',
      '4' => 'Great',
      '3' => 'Good',
      '2' => 'Fair',
      '1' => 'Poor' }.invert
  end

  def in_or_post_week?
    AnnualSchedule.in_week? || AnnualSchedule.post_week?
  end

end
