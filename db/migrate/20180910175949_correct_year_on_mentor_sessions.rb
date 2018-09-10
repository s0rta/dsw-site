class CorrectYearOnMentorSessions < ActiveRecord::Migration[5.1]
  def up
    change_column :mentor_sessions, :year, 'integer USING CAST(year AS integer)'
  end

  def down
    change_column :mentor_sessions, :year, :string
  end
end
