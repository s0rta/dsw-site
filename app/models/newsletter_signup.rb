class NewsletterSignup < ActiveRecord::Base

  attr_accessible :email,
                  :first_name,
                  :last_name

  after_create :subscribe_to_list

  def subscribe_to_list
    ListSubscriptionJob.perform(email, first_name, last_name)
  end

end
