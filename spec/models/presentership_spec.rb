require 'rails_helper'

RSpec.describe Presentership, type: :model do
  it { is_expected.to belong_to(:submission) }
  it { is_expected.to belong_to(:user) }
end
