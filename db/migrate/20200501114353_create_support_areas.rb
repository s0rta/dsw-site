class CreateSupportAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :support_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
