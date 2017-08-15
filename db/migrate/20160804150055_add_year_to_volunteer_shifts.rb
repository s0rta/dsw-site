class AddYearToVolunteerShifts < ActiveRecord::Migration[4.2]
  def change
    add_column :volunteer_shifts, :year, :integer
  end
end
