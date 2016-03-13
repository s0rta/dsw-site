class VolunteerSignup < ActiveRecord::Base

  after_create :notify_chairs

  def notify_chairs
    NotificationsMailer.notify_of_new_volunteer_signup(self).deliver
  end

end
