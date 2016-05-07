require 'spec_helper'

describe ListSubscriptionJob, job: true do
  it 'subscribes to a list' do
    ENV['EMMA_GROUP_ID'] = '12345'
    expect_any_instance_of(Emma::Client).to receive(:add_member).with(email: 'test@example.com',
                                                                      group_ids: [ '12345' ],
                                                                      fields: {
                                                                        first_name: 'Test',
                                                                        last_name: 'User'
                                                                      })
    ListSubscriptionJob.perform_async('test@example.com',
                                      first_name: 'Test',
                                      last_name: 'User')
  end
end
