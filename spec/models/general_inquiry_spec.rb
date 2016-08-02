require 'spec_helper'

describe GeneralInquiry do
  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  it 'subscribes after creation' do
    described_class.create! contact_email: 'test@example.com'
    expect(ListSubscriptionJob).to have_received(:perform_async).with('test@example.com')
  end
end
