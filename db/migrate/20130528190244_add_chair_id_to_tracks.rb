class AddChairIdToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :chair_id, :integer
  end
end
