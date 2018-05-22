class AddVenueHostToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :venue_host_id, :integer
  end
end
