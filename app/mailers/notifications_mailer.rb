class NotificationsMailer < ActionMailer::Base

  include ScheduleHelper
  helper ScheduleHelper

  default from: 'Denver Startup Week <info@denverstartupweek.org>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_submission.subject
  #
  def notify_of_new_submission(chair, submission)
    @chair = chair
    @submission = submission
    @track = @submission.track
    mail to: chair.email, subject: "A new DSW submission has been received for the #{@track.name} track"
  end

  def confirm_new_submission(submission)
    @submission = submission
    mail to: @submission.contact_email, subject: 'Thanks for submitting a session proposal for Denver Startup Week!'
  end

  def voting_open(submission)
    @submission = submission
    mail to: @submission.contact_email, subject: 'Voting for Denver Startup Week Sessions Is Now Open!'
  end

  def notify_of_new_volunteer_signup(volunteer_signup)
    @volunteer_signup = volunteer_signup
    mail to: ENV['VOLUNTEER_SIGNUP_EMAIL_RECIPIENTS'].split(','), subject: 'Someone has volunteered to help out with DSW'
  end

  def notify_of_new_sponsor_signup(sponsor_signup)
    @sponsor_signup = sponsor_signup
    mail to: ENV['SPONSOR_SIGNUP_EMAIL_RECIPIENTS'].split(','), subject: 'Someone is interested in sponsoring DSW'
  end

  def notify_of_submission_acceptance(submission)
    @submission = submission
    mail to: @submission.contact_email,
         subject: 'Your session proposal for Denver Startup Week',
         from: @submission.track.email_alias,
         reply_to: @submission.track.email_alias,
         cc: @submission.track.email_alias
  end

  def notify_of_submission_rejection(submission)
    @submission = submission
    mail to: @submission.contact_email,
         subject: 'Your session proposal for Denver Startup Week'
  end

  def confirm_registration(registration)
    @registration = registration
    mail to: @registration.contact_email,
      subject: "You are registered for Denver Startup Week #{Date.today.year}"
  end

  def notify_of_daily_schedule(registration, day)
    @day = day - 2
    @registration = registration
    @sessions = @registration.submissions.where(start_day: day).order('start_hour ASC')
    mail to: @registration.contact_email, subject: "Your Denver Startup Week Schedule for #{formatted_start_date_for_index(@day, '%A %-m/%-d')}"
  end

end
