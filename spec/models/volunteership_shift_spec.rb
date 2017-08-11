require 'rails_helper'

RSpec.describe VolunteershipShift, type: :model do
  it { is_expected.to belong_to(:volunteership) }
  it { is_expected.to belong_to(:volunteer_shift) }
end
