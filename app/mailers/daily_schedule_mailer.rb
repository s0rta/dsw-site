class DailyScheduleMailer < ApplicationMailer

  ASM_GROUP_ID = 7637

  sendgrid_enable :subscriptiontrack
  sendgrid_category :daily_schedule
  sendgrid_subscriptiontrack_text replace: '[unsub]'

  def notify_of_monday_daily_schedule(registration)
    sendgrid_asm_group_id ASM_GROUP_ID
    @day = 0
    @registration = registration
    @sessions = @registration.
                submissions.
                for_schedule.
                where(start_day: @day + 2).
                order('start_hour ASC')
    mail to: @registration.user.email,
         subject: "Your Denver Startup Week Daily Schedule for #{formatted_day_for_subject(@day + 2)}"
  end

  def notify_of_tuesday_daily_schedule(registration)
    sendgrid_asm_group_id ASM_GROUP_ID
    @day = 1
    @registration = registration
    @sessions = @registration.
                submissions.
                for_schedule.
                where(start_day: @day + 2).
                order('start_hour ASC')
    mail to: @registration.user.email,
         subject: "Your Denver Startup Week Daily Schedule for #{formatted_day_for_subject(@day + 2)}"
  end

  def notify_of_wednesday_daily_schedule(registration)
    sendgrid_asm_group_id ASM_GROUP_ID
    @day = 2
    @registration = registration
    @sessions = @registration.
                submissions.
                for_schedule.
                where(start_day: @day + 2).
                order('start_hour ASC')
    mail to: @registration.user.email,
         subject: "Your Denver Startup Week Daily Schedule for #{formatted_day_for_subject(@day + 2)}"
  end

  def notify_of_thursday_daily_schedule(registration)
    sendgrid_asm_group_id ASM_GROUP_ID
    @day = 3
    @registration = registration
    @sessions = @registration.
                submissions.
                for_schedule.
                where(start_day: @day + 2).
                order('start_hour ASC')
    mail to: @registration.user.email,
         subject: "Your Denver Startup Week Daily Schedule for #{formatted_day_for_subject(@day + 2)}"
  end

  def notify_of_friday_daily_schedule(registration)
    sendgrid_asm_group_id ASM_GROUP_ID
    @day = 4
    @registration = registration
    @sessions = @registration.
                submissions.
                for_schedule.
                where(start_day: @day + 2).
                order('start_hour ASC')
    mail to: @registration.user.email,
         subject: "Your Denver Startup Week Daily Schedule for #{formatted_day_for_subject(@day + 2)}"
  end

  private

  def formatted_day_for_subject(day)
    formatted_start_date_for_index(day, Date.today.year, '%A %-m/%-d')
  end
end
