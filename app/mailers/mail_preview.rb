class MailPreview < MailView

  def notify_of_daily_schedule
    registration = Registration.find(5)
    NotificationsMailer.notify_of_daily_schedule(registration, 2)
  end

end
