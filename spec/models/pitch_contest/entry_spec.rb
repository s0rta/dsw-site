require 'rails_helper'

RSpec.describe PitchContest::Entry, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:video_url) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }

  it { is_expected.to allow_value('youtu.be/EK7J_ZzvF8k').for(:video_url) }
  it { is_expected.to allow_value('http://youtu.be/EK7J_ZzvF8k').for(:video_url) }
  it { is_expected.to allow_value('https://youtu.be/EK7J_ZzvF8k').for(:video_url) }
  it { is_expected.not_to allow_value('youtube.com/watch?v=EK7J_ZzvF8k').for(:video_url) }
  it { is_expected.not_to allow_value('youtube.com/watch').for(:video_url) }

  describe 'transforming Youtube URLs into embed URLs' do
    it 'transforms a non-http/https URL' do
      expect(PitchContest::Entry.new(video_url: 'youtube.com/watch?v=EK7J_ZzvF8k').embed_video_url).
        to eq('https://www.youtube.com/embed/EK7J_ZzvF8k')
    end

    it 'transforms an http URL' do
      expect(PitchContest::Entry.new(video_url: 'http://youtube.com/watch?v=EK7J_ZzvF8k').embed_video_url).
        to eq('https://www.youtube.com/embed/EK7J_ZzvF8k')
    end

    it 'transforms an https URL' do
      expect(PitchContest::Entry.new(video_url: 'https://youtube.com/watch?v=EK7J_ZzvF8k').embed_video_url).
        to eq('https://www.youtube.com/embed/EK7J_ZzvF8k')
    end
  end
end
