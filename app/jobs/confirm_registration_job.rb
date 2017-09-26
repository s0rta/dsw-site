class ConfirmRegistrationJob

  include Sidekiq::Worker

  def perform(registration_id)
    registration = Registration.find(registration_id)
    NotificationsMailer.confirm_registration(registration).deliver_now
  end

end
