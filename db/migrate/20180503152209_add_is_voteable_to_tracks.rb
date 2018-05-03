class AddIsVoteableToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :is_voteable, :boolean, default: true, null: false
  end
end
