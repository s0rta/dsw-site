class AddCapacityToVenues < ActiveRecord::Migration[4.2]
  def change
    add_column :venues, :capacity, :integer, default: 0
  end
end
