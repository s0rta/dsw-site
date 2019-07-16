class AddPinnedToTrackToPublishings < ActiveRecord::Migration[5.2]
  def change
    add_column :publishings, :pinned_to_track, :boolean, default: false, null: false
  end
end
