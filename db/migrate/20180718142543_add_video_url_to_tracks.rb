class AddVideoUrlToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :video_url, :string
  end
end
