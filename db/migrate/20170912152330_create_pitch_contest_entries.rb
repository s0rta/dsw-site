class CreatePitchContestEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :pitch_contest_entries do |t|
      t.string :video_url
      t.string :name

      t.timestamps
    end
  end
end
