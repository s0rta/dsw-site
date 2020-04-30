require "rails_helper"

RSpec.describe Givetoo::Idea, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:kind).in_array(described_class::KINDS) }
end
