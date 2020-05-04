require "rails_helper"

RSpec.describe Resource, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(150) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_and_belong_to_many(:support_areas) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:company) }

  describe "finding related resources" do
    let(:user) { create(:user) }
    let(:company) { create(:company) }
    let(:support_area) { create(:support_area) }
    let(:industry_type) { create(:industry_type) }
    let(:resource) do
      create(:resource,
        user: user,
        support_areas: [support_area],
        company: company,
        industry_type: industry_type
      )
    end

    it "returns nothing if no other resources exist" do
      expect(resource.related).to be_empty
    end

    describe "when resources from the same user exist" do
      let!(:other_resource) { create(:resource, user: user) }

      it "returns resources from the same user" do
        expect(resource.related).to include(other_resource)
      end
    end

    describe "when resources from the same company exist" do
      let!(:other_resource) { create(:resource, company: company) }

      it "returns resources from the same company" do
        expect(resource.related).to include(other_resource)
      end
    end

    describe "when resources from the same support_areas exist" do
      let(:other_support_area) { create(:support_area) }
      let!(:other_resource) { create(:resource, support_areas: [support_area, other_support_area]) }

      it "returns resources from the same support_area" do
        expect(resource.related).to include(other_resource)
      end
    end

    describe "when resources from the same industry_type exist" do
      let!(:other_resource) { create(:resource, industry_type: industry_type) }

      it "returns resources from the same industry_type" do
        expect(resource.related).to include(other_resource)
      end
    end
  end

  describe '#active?' do
    it "returns true if resource has no expiration date" do
      resource = create(:resource)
      expect(resource.active?).to eq true
    end

    it "returns false if resource has expiration date in the past" do
      resource = create(:resource, expiration_date: Date.today - 1)
      expect(resource.active?).to eq false
    end

    it "returns true if resource has expiration date in the future" do
      resource = create(:resource, expiration_date: Date.today + 1)
      expect(resource.active?).to eq true
    end

    it "returns false if resource has expiration date is today" do
      resource = create(:resource, expiration_date: Date.today)
      expect(resource.active?).to eq false
    end

    it "returns false if resource has expiration date is today" do
      resource = create(:resource, expiration_date: Date.today)
      expect(resource.active?).to eq false
    end
  end
end
