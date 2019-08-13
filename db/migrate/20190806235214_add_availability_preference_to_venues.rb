class AddAvailabilityPreferenceToVenues < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :availability_preference, :string
  end
end
