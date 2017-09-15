class AddIndexOnCalendarTokenToRegistrations < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def change
    add_index :registrations, [:calendar_token], unique: true, algorithm: :concurrently
  end
end
