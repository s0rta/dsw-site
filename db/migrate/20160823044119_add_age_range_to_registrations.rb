class AddAgeRangeToRegistrations < ActiveRecord::Migration[4.2]
  def change
    add_column :registrations, :age_range, :string
  end
end
