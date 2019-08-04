class CreatePresenterships < ActiveRecord::Migration[5.1]
  def change
    create_table :presenterships do |t|
      t.references :submission, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
