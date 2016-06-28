class VolunteerSignup < ActiveRecord::Base

  after_create :notify_chairs,
               :subscribe_to_list

  def notify_chairs
    NotificationsMailer.notify_of_new_volunteer_signup(self).deliver_now
  end

  def subscribe_to_list
    ListSubscriptionJob.perform_async contact_email
  end

end
