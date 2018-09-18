class AddIsAmbassadorToRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :is_ambassador, :boolean, default: false, null: false
  end
end
