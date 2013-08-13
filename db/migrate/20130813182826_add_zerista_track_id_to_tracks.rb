class AddZeristaTrackIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :zerista_track_id, :integer
  end
end
