require 'spec_helper'

RSpec.describe SupportArea, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:color).in_array(SupportArea::COLORS) }

  it { is_expected.to allow_value("purple").for(:color) }
  it { is_expected.not_to allow_value("truck").for(:color) }
end
