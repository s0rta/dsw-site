class RemoveZeristaTrackIdFromTracks < ActiveRecord::Migration[4.2]
  def up
    remove_column :tracks, :zerista_track_id
  end

  def down
    add_column :tracks, :zerista_track_id, :integer
  end
end
