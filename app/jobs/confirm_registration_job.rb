class ConfirmRegistrationJob

  include SuckerPunch::Job

  def perform(registration)
    NotificationsMailer.confirm_registration(registration).deliver_now
  end

end
