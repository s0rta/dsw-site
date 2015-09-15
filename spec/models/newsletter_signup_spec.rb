require 'spec_helper'

describe NewsletterSignup do

  before do
    allow(ListSubscriptionJob).to receive(:perform)
  end

  it 'subscribes after creation' do
    NewsletterSignup.create! email: 'test@example.com',
                             first_name: 'Test',
                             last_name: 'User'
    expect(ListSubscriptionJob).to have_received(:perform).with('test@example.com',
                                                                first_name: 'Test',
                                                                last_name: 'User')
  end
end
