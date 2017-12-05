class CreateAnnualSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :annual_schedules do |t|
      t.integer :year
      t.jsonb :dates

      t.timestamps
    end

    add_index :annual_schedules, [ :year ], unique: true
  end
end
