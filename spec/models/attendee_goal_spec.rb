require 'rails_helper'

RSpec.describe AttendeeGoal, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_many(:registration_attendee_goals).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:registrations).through(:registration_attendee_goals) }
end
