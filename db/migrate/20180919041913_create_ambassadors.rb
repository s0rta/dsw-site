class CreateAmbassadors < ActiveRecord::Migration[5.1]
  def change
    create_table :ambassadors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company, null: false
      t.string :title, null: false
      t.string :location, null: false
      t.integer :year, null: false

      t.timestamps
    end
  end
end
