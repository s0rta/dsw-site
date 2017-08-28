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

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:contact_email) }
  # it { is_expected.to ensure_inclusion_of(:format).in_array(Submission::FORMATS) }
  # it { is_expected.to ensure_inclusion_of(:start_day).in_array(Submission::DAYS) }
  # it { is_expected.to ensure_inclusion_of(:end_day).in_array(Submission::DAYS) }
  # it { is_expected.to ensure_inclusion_of(:time_range).in_array(Submission::TIME_RANGES) }
  it { is_expected.to allow_value('test@example.com').for(:contact_email) }
  it { is_expected.not_to allow_value('test@ example').for(:contact_email) }
  it { is_expected.not_to allow_value('test').for(:contact_email) }
  it { is_expected.to validate_length_of(:location).is_at_most(255) }

  it 'defaults its year to the current year' do
    expect(Submission.new.year).to eq(Date.today.year)
  end

  describe 'subscribing to e-mail lists' do
    let(:user) { create(:user) }
    let(:track) { Track.create!(name: 'Test') }
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
  end
end
