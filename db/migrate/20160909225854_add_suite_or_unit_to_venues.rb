class AddSuiteOrUnitToVenues < ActiveRecord::Migration[4.2]
  def change
    add_column :venues, :suite_or_unit, :string
  end
end
