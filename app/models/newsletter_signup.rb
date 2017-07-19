class NewsletterSignup < ApplicationRecord

  after_create :subscribe_to_list

  def subscribe_to_list
    ListSubscriptionJob.perform_async email,
                                first_name: first_name,
                                last_name: last_name
  end

end
