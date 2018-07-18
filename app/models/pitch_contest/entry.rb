class PitchContest::Entry < ApplicationRecord

  include YearScoped
  include ValidatedVideoUrl

  self.table_name = 'pitch_contest_entries'

  validates :name,
            :year,
            presence: true

  has_many :votes, class_name: 'PitchContest::Vote', dependent: :destroy, foreign_key: :pitch_contest_entry_id

  def self.active
    where(is_active: true)
  end
end
