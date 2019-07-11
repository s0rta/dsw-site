require "rails_helper"

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(150) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to have_many(:authors) }
  it { is_expected.to have_many(:authorships).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:tracks) }
  it { is_expected.to have_one(:publishing).dependent(:destroy) }

  it { is_expected.to allow_value("youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.to allow_value("http://youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.to allow_value("https://youtu.be/EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.not_to allow_value("youtube.com/watch?v=EK7J_ZzvF8k").for(:video_url) }
  it { is_expected.not_to allow_value("youtube.com/watch").for(:video_url) }

  describe "transforming Youtube URLs into embed URLs" do
    it "transforms a non-http/https URL" do
      expect(Article.new(video_url: "youtu.be/EK7J_ZzvF8k").embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end

    it "transforms an http URL" do
      expect(Article.new(video_url: "http://youtu.be/EK7J_ZzvF8k").embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end

    it "transforms an https URL" do
      expect(Article.new(video_url: "https://youtu.be/EK7J_ZzvF8k").embed_video_url).to eq("https://www.youtube.com/embed/EK7J_ZzvF8k?modestbranding=1&showinfo=0")
    end
  end
end
