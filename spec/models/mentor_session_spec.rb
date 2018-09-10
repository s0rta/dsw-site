require 'rails_helper'

RSpec.describe MentorSession, type: :model do
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:timeslot) }
  it { is_expected.to validate_presence_of(:signup_url) }

  it { is_expected.not_to allow_value('google.com').for(:signup_url) }
end
