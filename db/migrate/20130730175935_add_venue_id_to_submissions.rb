class AddVenueIdToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :venue_id, :integer
  end
end
