class ListSubscriptionJob

  SENDGRID_FIELDS = %i(first_name last_name).freeze

  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
  sidekiq_throttle(
    concurrency: { limit: 10 },
    threshold: { limit: 3, period: 2.seconds }
  )

  def perform(email, extra_fields = {})
    subscribe_to_sendgrid(email, extra_fields)
  end

  private

  class SendGridContactCreateFailedError < StandardError
  end

  class SendGridListAddFailedError < StandardError
  end

  class SendGridListCreateFailedError < StandardError
  end

  def subscribe_to_sendgrid(email, extra_fields)
    recipient_id = create_or_update_recipient(email, extra_fields)
    list_ids_to_add_to(extra_fields).each do |list_id|
      response = sg.client.contactdb.lists._(list_id.to_i).recipients._(recipient_id).post
      raise SendGridListAddFailedError.new("Error adding recipient to list: #{response.body}") unless response.status_code.to_s == '201'
    end
  end

  private

  def create_or_update_recipient(email, extra_fields)
    data = { email: email }.merge(extra_fields.symbolize_keys.slice(*SENDGRID_FIELDS))
    response = sg.client.contactdb.recipients.patch(request_body: [ data ])
    raise SendGridContactCreateFailedError.new("Error updating recipient: #{response.body}") unless response.status_code.to_s == '201'
    JSON.parse(response.body)['persisted_recipients'].first
  end

  def list_ids_to_add_to(extra_fields)
    # Start with the general info list
    list_ids = [ ENV['SENDGRID_LIST_ID'] ]

    # Create/add submitted lists
    if submitted_years = extra_fields['submitted_years']
      submitted_years.each do |year|
        list_name = "DSW Submitters #{year}"
        list_ids << (all_lists[list_name] || create_list(list_name))
      end
    end

    # Create/add confirmed lists
    if confirmed_years = extra_fields['confirmed_years']
      confirmed_years.each do |year|
        list_name = "DSW Presenters #{year}"
        list_ids << (all_lists[list_name] || create_list(list_name))
      end
    end

    list_ids
  end

  def sg
    @sg ||= SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def create_list(name)
    response = sg.client.contactdb.lists.post(request_body: { name: name })
    raise SendGridListCreateFailedError.new("Error creating list #{name}: #{response.body}") unless response.status_code.to_s == '201'
    JSON.parse(response.body)['id']
  end

  def all_lists
    @all_lists ||= JSON.parse(sg.client.contactdb.lists.get().body)['lists'].each_with_object({}) do |list, memo|
      memo[list['name']] = list['id']
    end
  end
end
