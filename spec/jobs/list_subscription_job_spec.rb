require 'spec_helper'

describe ListSubscriptionJob, job: true do

  it 'subscribes to a list' do
    ENV['EMMA_GROUP_ID'] = '12345'
    Emma::Setup.any_instance.should_receive(:add_member).with(email: 'test@example.com',
                                                                     group_ids: [ '12345' ],
                                                                     fields: {
                                                                       first_name: 'Test',
                                                                       last_name: 'User'
                                                                      })
    ListSubscriptionJob.perform('test@example.com', 'Test', 'User')
  end

end
