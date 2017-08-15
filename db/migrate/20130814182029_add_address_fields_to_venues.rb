class AddAddressFieldsToVenues < ActiveRecord::Migration[4.2]
  def change
    add_column :venues, :address, :string
    add_column :venues, :city, :string
    add_column :venues, :state, :string
  end
end
