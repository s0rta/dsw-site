class AddChairIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :chair_id, :integer
  end
end
