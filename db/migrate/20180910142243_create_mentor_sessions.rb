class CreateMentorSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :mentor_sessions do |t|
      t.string :year, null: false
      t.string :title, null: false
      t.string :timeslot, null: false
      t.string :signup_url, null: false

      t.timestamps
    end
  end
end
