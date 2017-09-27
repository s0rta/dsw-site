class MailPreview < ActionMailer::Preview

  def notify_of_monday_daily_schedule
    registration = Registration.find(5)
    DailyScheduleMailer.notify_of_monday_daily_schedule(registration)
  end

  def notify_of_tuesday_daily_schedule
    registration = Registration.find(5)
    DailyScheduleMailer.notify_of_tuesday_daily_schedule(registration)
  end

  def notify_of_wednesday_daily_schedule
    registration = Registration.find(5)
    DailyScheduleMailer.notify_of_wednesday_daily_schedule(registration)
  end

  def notify_of_thursday_daily_schedule
    registration = Registration.find(5)
    DailyScheduleMailer.notify_of_thursday_daily_schedule(registration)
  end

  def notify_of_friday_daily_schedule
    registration = Registration.find(5)
    DailyScheduleMailer.notify_of_friday_daily_schedule(registration)
  end

end
