class AddIconToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :icon, :string
  end
end
