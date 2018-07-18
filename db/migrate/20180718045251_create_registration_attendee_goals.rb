class CreateRegistrationAttendeeGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_attendee_goals do |t|
      t.references :registration, foreign_key: true, null: false
      t.references :attendee_goal, foreign_key: true, null: false
      t.timestamps
    end
  end
end
