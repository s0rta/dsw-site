class AddYearToPitchContestEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :pitch_contest_entries, :year, :integer
  end
end
