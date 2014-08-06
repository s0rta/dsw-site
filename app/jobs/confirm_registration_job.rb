class ConfirmRegistrationJob

  def self.perform(registration)
    new.async.perform(registration)
  end

  include SuckerPunch::Job

  def perform(registration)
    NotificationsMailer.confirm_registration(registration).deliver
  end

end
