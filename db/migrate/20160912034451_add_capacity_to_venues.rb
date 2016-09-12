class AddCapacityToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :capacity, :integer, default: 0
  end
end
