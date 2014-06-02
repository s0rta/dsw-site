class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :user
      t.integer :year
      t.string :contact_email
      t.string :zip
      t.string :company
      t.string :gender
      t.string :primary_role
      t.references :track

      t.timestamps
    end
    add_index :registrations, :user_id
  end
end
