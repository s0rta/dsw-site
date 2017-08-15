class CreateSessionRegistrations < ActiveRecord::Migration[4.2]
  def change
    create_table :session_registrations do |t|
      t.references :registration
      t.references :submission

      t.timestamps
    end
    add_index :session_registrations, :registration_id
    add_index :session_registrations, :submission_id
  end
end
