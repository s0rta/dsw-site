require "spec_helper"

RSpec.describe Track, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email_alias) }
  it { is_expected.to validate_presence_of(:icon) }
  it { is_expected.to validate_presence_of(:color) }
  it { is_expected.to have_many(:submissions).dependent(:restrict_with_error) }
  it { is_expected.to have_and_belong_to_many(:chairs) }
  it { is_expected.to have_and_belong_to_many(:articles).dependent(:restrict_with_error) }

  it { is_expected.to allow_value("eyeball").for(:icon) }
  it { is_expected.not_to allow_value("truck").for(:icon) }
  it { is_expected.to allow_value("orange").for(:color) }
  it { is_expected.not_to allow_value("truck").for(:color) }

  it { is_expected.to allow_value(nil).for(:video_url) }
  it { is_expected.to allow_value("").for(:video_url) }
  it { is_expected.to allow_value("youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.to allow_value("http://youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.to allow_value("https://youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.not_to allow_value("youtube.com/watch?v=EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.not_to allow_value("youtube.com/watch").for(:video_url) }

  describe "transforming Youtube URLs into embed URLs" do
    it "transforms a non-http/https URL" do
      t = described_class.new(video_url: "youtu.be/EK7J_ZzvF8k")
      expect(t.embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end

    it "transforms an http URL" do
      t = described_class.new(video_url: "http://youtu.be/EK7J_ZzvF8k")
      expect(t.embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end

    it "transforms an https URL" do
      t = described_class.new(video_url: "https://youtu.be/EK7J_ZzvF8k")
      expect(t.embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end
  end
end
