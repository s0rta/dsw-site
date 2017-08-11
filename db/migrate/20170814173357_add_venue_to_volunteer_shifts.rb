class AddVenueToVolunteerShifts < ActiveRecord::Migration[5.1]
  def change
    add_reference :volunteer_shifts, :venue, foreign_key: true
  end
end
