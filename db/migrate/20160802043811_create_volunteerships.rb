class CreateVolunteerships < ActiveRecord::Migration[4.2]
  def change
    create_table :volunteerships do |t|
      t.string :mobile_phone_number
      t.string :affiliated_organization
      t.references :user, index: true, foreign_key: true
      t.integer :year

      t.timestamps null: false
    end
  end
end
