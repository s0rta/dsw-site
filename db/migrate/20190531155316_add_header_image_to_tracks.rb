class AddHeaderImageToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :header_image, :string
  end
end
