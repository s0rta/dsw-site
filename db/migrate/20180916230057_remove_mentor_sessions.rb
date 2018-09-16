class RemoveMentorSessions < ActiveRecord::Migration[5.1]
  def change
    drop_table :mentor_sessions
  end
end
