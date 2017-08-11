class CreateVolunteershipShiftsAgain < ActiveRecord::Migration[5.1]
  def change
    create_table :volunteership_shifts do |t|
      t.references :volunteership, foreign_key: true
      t.references :volunteer_shift, foreign_key: true

      t.timestamps
    end

    drop_table :volunteership_assigned_shifts
    drop_table :volunteership_available_shifts
  end
end
