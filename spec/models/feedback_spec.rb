require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:submission) }

  it { is_expected.to allow_value(1).for(:rating) }
  it { is_expected.to allow_value(5).for(:rating) }
  it { is_expected.not_to allow_value(0).for(:rating) }
  it { is_expected.not_to allow_value(6).for(:rating) }
end
