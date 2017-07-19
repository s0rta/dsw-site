class GeneralInquiry < ApplicationRecord

  after_create :notify_inbox,
               :subscribe_to_list

  def notify_inbox
    NotificationsMailer.notify_of_new_inquiry(self).deliver_now
  end

  def subscribe_to_list
    ListSubscriptionJob.perform_async contact_email
  end

end
