class AddLearnMorePledge1pToRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :learn_more_pledge_1p, :boolean, default: false, null: false
  end
end
