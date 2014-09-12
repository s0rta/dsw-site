class AddCalendarTokenToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :calendar_token, :string
  end
end
