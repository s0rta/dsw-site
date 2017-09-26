class DailyScheduleMailer < ApplicationMailer

  sendgrid_asm_group_id 3437
  sendgrid_subscriptiontrack_text replace: '|unsub|'

  def notify_of_monday_daily_schedule(registration)
    @day = 0
    @registration = registration
    @sessions = @registration.submissions.where(start_day: @day+ 2).order('start_hour ASC')
    mail to: @registration.user.email, subject: "Your Denver Startup Week Daily Schedule for #{formatted_start_date_for_index(@day + 2, '%A %-m/%-d')}"
  end

  def notify_of_tuesday_daily_schedule(registration)
    @day = 1
    @registration = registration
    @sessions = @registration.submissions.where(start_day: @day + 2).order('start_hour ASC')
    mail to: @registration.user.email, subject: "Your Denver Startup Week Daily Schedule for #{formatted_start_date_for_index(@day + 2, '%A %-m/%-d')}"
  end

  def notify_of_wednesday_daily_schedule(registration)
    @day = 2
    @registration = registration
    @sessions = @registration.submissions.where(start_day: @day + 2).order('start_hour ASC')
    mail to: @registration.user.email, subject: "Your Denver Startup Week Daily Schedule for #{formatted_start_date_for_index(@day + 2, '%A %-m/%-d')}"
  end

  def notify_of_thursday_daily_schedule(registration)
    @day = 3
    @registration = registration
    @sessions = @registration.submissions.where(start_day: @day + 2).order('start_hour ASC')
    mail to: @registration.user.email, subject: "Your Denver Startup Week Daily Schedule for #{formatted_start_date_for_index(@day + 2, '%A %-m/%-d')}"
  end

  def notify_of_friday_daily_schedule(registration)
    @day = 4
    @registration = registration
    @sessions = @registration.submissions.where(start_day: @day + 2).order('start_hour ASC')
    mail to: @registration.user.email, subject: "Your Denver Startup Week Daily Schedule for #{formatted_start_date_for_index(@day + 2, '%A %-m/%-d')}"
  end
end
