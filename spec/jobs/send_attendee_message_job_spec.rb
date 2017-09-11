require 'spec_helper'

describe SendAttendeeMessageJob, job: true do
  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  let(:msg) do
    FactoryGirl.create(:attendee_message, subject: 'Important', body: 'Please read me')
  end

  let(:registration) do
    FactoryGirl.create(:registration)
  end

  it 'sends a message' do
    msg.submission.user_registrations << registration
    SendAttendeeMessageJob.new.perform(msg)
    expect(last_email_sent).to deliver_to('info@denverstartupweek.org')
    expect(last_email_sent).to have_subject("Regarding '#{msg.submission.full_title}': Important")
    expect(last_email_sent).to have_body_text(/Please read me/)
    expect(last_email_sent).to have_header('X-SMTPAPI', "{\"to\": [\"#{registration.user.email}\"]}")
  end
end
