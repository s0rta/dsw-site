require 'spec_helper'

RSpec.describe Submission, type: :model do
  it { is_expected.to belong_to(:track) }
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
  it { is_expected.to validate_length_of(:location).is_at_most(255) }

  it 'defaults its year to the current year' do
    expect(Submission.new.year).to eq(Date.today.year)
  end
end
