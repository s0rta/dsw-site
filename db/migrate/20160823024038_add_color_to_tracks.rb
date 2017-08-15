class AddColorToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :color, :string
  end
end
