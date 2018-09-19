class RemoveIsAmbassadorFromRegistrations < ActiveRecord::Migration[5.1]
  def change
    remove_column :registrations, :is_ambassador
  end
end
