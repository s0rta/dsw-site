class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :submission
      t.text :body

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :submission_id
  end
end
