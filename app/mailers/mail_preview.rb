class MailPreview < MailView

  def notify_of_monday_daily_schedule
    registration = Registration.find(5)
    NotificationsMailer.notify_of_monday_daily_schedule(registration)
  end

  def notify_of_tuesday_daily_schedule
    registration = Registration.find(5)
    NotificationsMailer.notify_of_tuesday_daily_schedule(registration)
  end

end
