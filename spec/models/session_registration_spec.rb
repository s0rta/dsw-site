require 'spec_helper'

RSpec.describe SessionRegistration, type: :model do
  it { is_expected.to belong_to(:submission) }
  it { is_expected.to belong_to(:registration) }
end
