class TracksHaveManyChairs < ActiveRecord::Migration
  def up
    create_table :tracks_users, id: false do |t|
      t.references :track
      t.references :user
    end
    Track.find_each do |t|
      t.chairs << User.find(t.chair_id)
    end
    remove_column :tracks, :chair_id
  end

  def down
    remove_column :tracks, :chair_id
    create_table :tracks_users, id: false do |t|
      t.references :track
      t.references :user
    end
  end
end
