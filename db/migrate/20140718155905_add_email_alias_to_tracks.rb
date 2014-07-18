class AddEmailAliasToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :email_alias, :string
  end
end
