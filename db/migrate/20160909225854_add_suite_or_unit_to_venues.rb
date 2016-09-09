class AddSuiteOrUnitToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :suite_or_unit, :string
  end
end
