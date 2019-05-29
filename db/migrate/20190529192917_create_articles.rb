class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title, null: false
      t.text :body, null: false
      t.references :author, foreign_key: {to_table: :users}, null: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
