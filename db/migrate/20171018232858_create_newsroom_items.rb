class CreateNewsroomItems < ActiveRecord::Migration[5.1]
  def change
    create_table :newsroom_items do |t|
      t.string :title, null: false
      t.string :attachment
      t.string :external_link
      t.boolean :is_active, default: true, null: false

      t.date :release_date, null: false

      t.timestamps
    end
  end
end
