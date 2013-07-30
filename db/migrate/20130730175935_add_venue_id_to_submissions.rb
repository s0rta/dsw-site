class AddVenueIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :venue_id, :integer
  end
end
