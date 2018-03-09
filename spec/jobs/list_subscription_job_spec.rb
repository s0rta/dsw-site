require 'spec_helper'

describe ListSubscriptionJob, job: true, vcr: true do
  it 'subscribes to a list' do
    # This is not a great test, but I'm at a loss for better ways to handle this kind of stubbing
    allow_any_instance_of(SendGrid::API).to receive_message_chain(:client,
                                                                  :contactdb,
                                                                  :recipients,
                                                                  :patch).with(
                                                                    request_body: [
                                                                      {
                                                                        email: 'test@example.com',
                                                                        first_name: 'Test',
                                                                        last_name: 'User'
                                                                      }
                                                                    ]) do
                                                                      instance_double('SendGrid::Response',
                                                                                      body: '{ "persisted_recipients": [ 1 ] }',
                                                                                      status_code: 201)
                                                                    end

    allow_any_instance_of(SendGrid::API).to receive_message_chain(:client,
                                                                  :contactdb,
                                                                  :lists,
                                                                  :_,
                                                                  :recipients,
                                                                  :_,
                                                                  :post) do
                                                                    instance_double('SendGrid::Response', status_code: 201)
                                                                  end

    ListSubscriptionJob.perform_async('test@example.com',
                                      first_name: 'Test',
                                      last_name: 'User')
  end
end
