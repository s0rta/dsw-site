class AddAgeRangeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :age_range, :string
  end
end
