class AddEmailAliasToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :email_alias, :string
  end
end
