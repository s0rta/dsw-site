class CreateSponsorSignups < ActiveRecord::Migration
  def change
    create_table :sponsor_signups do |t|
      t.string :contact_name
      t.string :contact_email
      t.string :company
      t.text :interest
      t.text :notes

      t.timestamps
    end
  end
end
