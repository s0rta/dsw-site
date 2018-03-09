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

  def subscribe_to_sendgrid(email, extra_fields)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    list_id = ENV['SENDGRID_LIST_ID']
    data = { email: email }.merge(extra_fields.symbolize_keys.slice(*SENDGRID_FIELDS))
    response = sg.client.contactdb.recipients.patch(request_body: [ data ])
    raise SendGridContactCreateFailedError.new('Error updating recipient!') unless response.status_code.to_s == '201'
    recipient_id = JSON.parse(response.body)['persisted_recipients'].first
    response = sg.client.contactdb.lists._(list_id).recipients._(recipient_id).post
    raise SendGridListAddFailedError.new('Error adding recipient to list!') unless response.status_code.to_s == '201'
  end

end
