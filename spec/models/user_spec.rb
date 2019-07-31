require "spec_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:submissions).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }
  it { is_expected.to have_many(:registrations).dependent(:destroy) }
  it { is_expected.to have_many(:pitch_contest_votes).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:chaired_tracks).class_name("Track") }
  it { is_expected.to have_many(:venue_adminships).dependent(:destroy) }
  it { is_expected.to have_many(:administered_venues) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to allow_value(0).for(:team_priority) }
  it { is_expected.to allow_value(10).for(:team_priority) }
  it { is_expected.to allow_value(5).for(:team_priority) }
  it { is_expected.to allow_value(nil).for(:team_priority) }
  it { is_expected.not_to allow_value(-1).for(:team_priority) }
  it { is_expected.not_to allow_value(100).for(:team_priority) }

  describe "with a subject record present" do
    subject { create(:user) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "deriving initials" do
    it "works when a first and last name are specified" do
      u = build(:user, name: "Jay Zeschin")
      expect(u.initials).to eq("JZ")
    end

    it "doesn't explode when a name is empty" do
      u = build(:user, name: "")
      expect(u.initials).to be_blank
    end

    it "works when only a first name is specified" do
      u = build(:user, name: "Jay")
      expect(u.initials).to eq("J")
    end

    it "works when multiple last names are specified" do
      u = build(:user, name: "Jay Zeschin Smith")
      expect(u.initials).to eq("JZS")
    end
  end

  describe "deriving an abbreviated name" do
    it "works when a first and last name are specified" do
      u = build(:user, name: "Jay Zeschin")
      expect(u.abbreviated_name).to eq("Jay Z.")
    end

    it "works when only a first name is specified" do
      u = build(:user, name: "Jay")
      expect(u.abbreviated_name).to eq("Jay")
    end

    it "works when multiple last names are specified" do
      u = build(:user, name: "Jay Zeschin Smith")
      expect(u.abbreviated_name).to eq("Jay S.")
    end

    it "doesn't explode when a name is empty" do
      u = build(:user, name: "")
      expect(u.abbreviated_name).to be_blank
    end
  end
end
