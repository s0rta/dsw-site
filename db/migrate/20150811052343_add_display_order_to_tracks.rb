class AddDisplayOrderToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :display_order, :integer, null: false, default: 0
  end
end
