module ScheduleHelper
  def human_time_range(submission)
    "#{submission.start_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')} &mdash; #{submission.end_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')}".html_safe
  end
end
