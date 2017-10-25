require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    subject { FactoryGirl.build(:company) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it { is_expected.to have_many(:registrations).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:submissions).dependent(:restrict_with_error) }
end
