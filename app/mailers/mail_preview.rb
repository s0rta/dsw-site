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

  def session_thanks
    session = Submission.first
    NotificationsMailer.session_thanks(session)
  end

  def notify_of_submission_acceptance
    session = Submission.first
    NotificationsMailer.notify_of_submission_acceptance(session)
  end

  def notify_of_submission_rejection
    session = Submission.first
    NotificationsMailer.notify_of_submission_rejection(session)
  end

  def notify_of_submission_waitlisting
    session = Submission.first
    NotificationsMailer.notify_of_submission_waitlisting(session)
  end

end
