class AddIconToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :icon, :string
  end
end
