class CreateOldVolunteerSignups < ActiveRecord::Migration
  def change
    create_table :volunteer_signups do |t|
      t.string :contact_name
      t.string :contact_email
      t.text :interest
      t.text :notes

      t.timestamps
    end
  end
end
