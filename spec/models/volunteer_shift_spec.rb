require 'spec_helper'

RSpec.describe VolunteerShift, type: :model do
  it { is_expected.to belong_to(:venue) }
  it { is_expected.to validate_presence_of(:day) }
  it { is_expected.to validate_presence_of(:start_hour) }
  it { is_expected.to validate_presence_of(:end_hour) }
  it { is_expected.to validate_presence_of(:name) }
end
