class AddHasDetailPageToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :has_detail_page, :boolean, default: true, null: false
  end
end
