class NotificationsMailer < ActionMailer::Base
  default from: "robot@denverstartupweek.org"

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
end
