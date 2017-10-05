require 'spec_helper'

RSpec.describe Submission, type: :model do

  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  it { is_expected.to belong_to(:track) }
  it { is_expected.to belong_to(:venue) }
  it { is_expected.to belong_to(:cluster) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:session_registrations).dependent(:destroy) }
  it { is_expected.to have_many(:user_registrations) }
  it { is_expected.to have_many(:registrants) }
  it { is_expected.to have_many(:sent_notifications).dependent(:destroy) }
  it { is_expected.to have_many(:attendee_messages).dependent(:restrict_with_error) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:contact_email) }
  # it { is_expected.to ensure_inclusion_of(:format).in_array(Submission::FORMATS) }
  # it { is_expected.to ensure_inclusion_of(:start_day).in_array(Submission::DAYS) }
  # it { is_expected.to ensure_inclusion_of(:end_day).in_array(Submission::DAYS) }
  # it { is_expected.to ensure_inclusion_of(:time_range).in_array(Submission::TIME_RANGES) }
  it { is_expected.to allow_value('test@example.com').for(:contact_email) }
  it { is_expected.to validate_length_of(:location).is_at_most(255) }

  it 'defaults its year to the current year' do
    expect(Submission.new.year).to eq(Date.today.year)
  end

  describe 'subscribing to e-mail lists' do
    let(:user) { create(:user) }
    let(:track) { create(:track, name: 'Test') }
    let(:year) { Date.today.year.to_s }

    it 'subscribes after creation' do
      user.submissions.create! contact_email: 'test@example.com',
                               title: 'Test',
                               description: 'Test',
                               track: track
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test@example.com', submittedyears: [ year ], confirmedyears: [])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [])
    end

    it 'subscribes multiple e-mails after creation' do
      user.submissions.create! contact_email: 'test1@example.com, test2@example.com',
                               title: 'Test',
                               description: 'Test',
                               track: track
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test1@example.com', submittedyears: [ year ], confirmedyears: [])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test2@example.com', submittedyears: [ year ], confirmedyears: [])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [])
    end

    it 'resubscribes with new data after update' do
      submission = user.submissions.create! contact_email: user.email,
                                            title: 'Test',
                                            description: 'Test',
                                            track: track
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [])
      submission.update!(state: 'confirmed')
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [ year ])
    end

    it 'resubscribes multiple e-mails with new data after update' do
      submission = user.submissions.create! contact_email: 'test1@example.com, test2@example.com',
                                            title: 'Test',
                                            description: 'Test',
                                            track: track
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test1@example.com', submittedyears: [ year ], confirmedyears: [])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test2@example.com', submittedyears: [ year ], confirmedyears: [])

      submission.update!(state: 'confirmed')
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with(user.email, submittedyears: [ year ], confirmedyears: [ year ])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test1@example.com', submittedyears: [ year ], confirmedyears: [ year ])
      expect(ListSubscriptionJob).to have_received(:perform_async).
        with('test2@example.com', submittedyears: [ year ], confirmedyears: [ year ])
    end
  end

  describe 'sending e-mails' do
    let(:user) { create(:user, email: 'user@example.com') }
    let(:chair) { create(:user) }
    let(:track) { create(:track, chair_ids: [ chair.id ]) }
    let(:submission) do
      create(:submission,
             submitter: user,
             contact_email: 'test1@example.com, test2@example.com')
    end

    it 'sends and records an acceptance e-mail' do
      submission.send_accept_email!
      expect(submission.sent_notifications.size).to eq(1)
      last_sent_notification = submission.sent_notifications.last
      expect(last_sent_notification.kind).to eq(SentNotification::ACCEPTANCE_KIND)
      expect(last_sent_notification.recipient_email).to eq('test1@example.com, test2@example.com, user@example.com')
    end

    it 'sends and records a rejection e-mail' do
      submission.send_reject_email!
      expect(submission.sent_notifications.size).to eq(1)
      last_sent_notification = submission.sent_notifications.last
      expect(last_sent_notification.kind).to eq(SentNotification::REJECTION_KIND)
      expect(last_sent_notification.recipient_email).to eq('test1@example.com, test2@example.com, user@example.com')
    end

    it 'sends and records a waitlisting e-mail' do
      submission.send_waitlist_email!
      expect(submission.sent_notifications.size).to eq(1)
      last_sent_notification = submission.sent_notifications.last
      expect(last_sent_notification.kind).to eq(SentNotification::WAITLISTING_KIND)
      expect(last_sent_notification.recipient_email).to eq('test1@example.com, test2@example.com, user@example.com')
    end

    it 'sends and records a thanks e-mail' do
      submission.send_thanks_email!
      expect(submission.sent_notifications.size).to eq(1)
      last_sent_notification = submission.sent_notifications.last
      expect(last_sent_notification.kind).to eq(SentNotification::THANKS_KIND)
      expect(last_sent_notification.recipient_email).to eq('test1@example.com, test2@example.com, user@example.com')
    end
  end
end
