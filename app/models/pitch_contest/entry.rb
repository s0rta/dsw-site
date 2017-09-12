class PitchContest::Entry < ApplicationRecord

  include YearScoped

  YOUTUBE_REGEX = %r(youtu.be/(\S+))

  self.table_name = 'pitch_contest_entries'

  validates :name,
            :year,
            :video_url, presence: true

  validates :video_url, format: { with: YOUTUBE_REGEX }

  has_many :votes, class_name: PitchContest::Vote, dependent: :destroy, foreign_key: :pitch_contest_entry_id

  def embed_video_url
    "https://www.youtube.com/embed/#{YOUTUBE_REGEX.match(video_url)[1]}"
  end
end
