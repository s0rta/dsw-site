require 'spec_helper'

RSpec.describe Track, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email_alias) }
  it { is_expected.to validate_presence_of(:icon) }
  it { is_expected.to validate_presence_of(:color) }
  it { is_expected.to have_many(:submissions).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:chairs) }
  it { is_expected.to allow_value('eyeball').for(:icon) }
  it { is_expected.not_to allow_value('truck').for(:icon) }
  it { is_expected.to allow_value('orange').for(:color) }
  it { is_expected.not_to allow_value('truck').for(:color) }
end
