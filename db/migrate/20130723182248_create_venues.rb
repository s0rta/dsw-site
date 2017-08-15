class CreateVenues < ActiveRecord::Migration[4.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
