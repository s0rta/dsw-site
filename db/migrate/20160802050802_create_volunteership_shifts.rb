class CreateVolunteershipShifts < ActiveRecord::Migration
  def change
    create_table :volunteership_available_shifts do |t|
      t.references :volunteership, index: true, foreign_key: true
      t.references :volunteer_shift, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :volunteership_assigned_shifts do |t|
      t.references :volunteership, index: true, foreign_key: true
      t.references :volunteer_shift, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
