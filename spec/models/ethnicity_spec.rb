require "rails_helper"

RSpec.describe Ethnicity, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:registration_ethnicities).dependent(:restrict_with_error) }

  describe "with an existing record" do
    let!(:ethnicity) { described_class.create!(name: "Pacific Islander") }

    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
