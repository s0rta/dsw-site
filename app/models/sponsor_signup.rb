class SponsorSignup < ActiveRecord::Base

  after_create :notify_chairs

  def notify_chairs
    NotificationsMailer.notify_of_new_sponsor_signup(self).deliver
  end

end
