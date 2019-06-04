class AddVenueHostToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :company_id, :integer
    add_foreign_key :venues, :companies
  end
end
