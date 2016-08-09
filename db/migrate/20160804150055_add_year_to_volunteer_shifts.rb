class AddYearToVolunteerShifts < ActiveRecord::Migration
  def change
    add_column :volunteer_shifts, :year, :integer
  end
end
