class PopulateCalendarTokenOnRegistrations < ActiveRecord::Migration[4.2]
  def up
    Registration.find_each do |r|
      r.update_column :calendar_token, SecureRandom.hex(25)
    end
  end

  def down
    # No-op
  end
end
