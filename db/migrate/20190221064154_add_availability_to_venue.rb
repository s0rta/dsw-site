class AddAvailabilityToVenue < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_availabilities do |t|
      t.belongs_to :venue, index: true
      t.belongs_to :submission
      t.integer :year
      t.integer :day
      t.integer :time_block
    end
  end
end
