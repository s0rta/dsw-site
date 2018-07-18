class CreateAttendeeGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :attendee_goals do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
