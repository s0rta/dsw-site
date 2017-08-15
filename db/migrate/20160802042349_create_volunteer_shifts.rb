class CreateVolunteerShifts < ActiveRecord::Migration[4.2]
  def change
    create_table :volunteer_shifts do |t|
      t.string :name
      t.integer :day
      t.float :start_hour
      t.float :end_hour

      t.timestamps null: false
    end
  end
end
