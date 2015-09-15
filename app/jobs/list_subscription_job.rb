class ListSubscriptionJob

  def self.perform(email, extra_fields = {})
    new.async.perform(email, extra_fields)
  end

  include SuckerPunch::Job

  def perform(email, extra_fields = {})
    em = Emma::Setup.new(ENV['EMMA_ACCOUNT_ID'],
                         ENV['EMMA_PUBLIC_KEY'],
                         ENV['EMMA_PRIVATE_KEY'])
    em.add_member email: email,
                  group_ids: [ ENV['EMMA_GROUP_ID'] ],
                  fields: extra_fields.symbolize_keys
  end

end
