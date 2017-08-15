class AddCalendarTokenToRegistrations < ActiveRecord::Migration[4.2]
  def change
    add_column :registrations, :calendar_token, :string
  end
end
