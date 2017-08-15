class AddZeristaTrackIdToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :zerista_track_id, :integer
  end
end
