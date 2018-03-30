module ScheduleHelper

  def formatted_start_date_for_index(index, year, format = '%B %-d')
    (AnnualSchedule.find_by!(year: year).week_start_at + index - 2).strftime(format)
  end

  def registered_for_session?(submission)
    registered? && current_registration.submission_ids.include?(submission.id)
  end

  def ratings_for_select
    { '1' => 'Poor',
      '2' => 'Fair',
      '3' => 'Good',
      '4' => 'Great',
      '5' => 'Outstanding' }.invert
  end

end
