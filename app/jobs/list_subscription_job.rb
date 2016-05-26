class ListSubscriptionJob

  include SuckerPunch::Job

  def perform(email, extra_fields = {})
    em = Emma::Client.new(account_id: ENV['EMMA_ACCOUNT_ID'],
                          public_key: ENV['EMMA_PUBLIC_KEY'],
                          private_key: ENV['EMMA_PRIVATE_KEY'])
    em.add_member email: email,
                  group_ids: [ ENV['EMMA_GROUP_ID'] ],
                  fields: extra_fields.symbolize_keys
  end

end
