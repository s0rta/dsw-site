class PitchContest::Vote < ApplicationRecord

  self.table_name = 'pitch_contest_votes'

  belongs_to :user
  belongs_to :entry, class_name: PitchContest::Entry, foreign_key: :pitch_contest_entry_id
end
