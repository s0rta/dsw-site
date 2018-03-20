class AddCocAcknowledgementToRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :coc_acknowledgement, :boolean, default: false, null: false
  end
end
