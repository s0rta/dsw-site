class CreatePitchContestVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :pitch_contest_votes do |t|
      t.references :user, foreign_key: true
      t.references :pitch_contest_entry, foreign_key: true

      t.timestamps
    end
  end
end
