class ListSubscriptionJob

  def self.perform(email, first_name = nil, last_name = nil)
    new.async.perform(email, first_name, last_name)
  end

  include SuckerPunch::Job

  def perform(email, first_name = nil, last_name = nil)
    em = Emma::Setup.new ENV['EMMA_ACCOUNT_ID'],
                         ENV['EMMA_PUBLIC_KEY'],
                         ENV['EMMA_PRIVATE_KEY']
    em.add_member email: email,
                  group_ids: [ ENV['EMMA_GROUP_ID'] ],
                  fields: { first_name: first_name,
                            last_name: last_name }
  end

end
