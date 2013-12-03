class SponsorSignup < ActiveRecord::Base
  attr_accessible :contact_email, :contact_name, :company, :interest, :notes

  after_create :notify_chairs

  def notify_chairs
    NotificationsMailer.notify_of_new_sponsor_signup(self).deliver
  end

end
