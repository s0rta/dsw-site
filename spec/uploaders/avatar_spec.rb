require "carrierwave/test/matchers"
require "spec_helper"

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { build_stubbed(:user) }
  let(:uploader) { AvatarUploader.new(user, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open(Rails.root.join("spec", "support", "avatar_examples", "less_than_2_mb.png")) { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context "the thumb version" do
    it "scales down a landscape image to be exactly 100 by 100 pixels" do
      expect(uploader.thumb).to have_dimensions(100, 100)
    end
  end

  it "has the correct format" do
    expect(uploader).to be_format("png")
  end
end
