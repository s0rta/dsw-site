class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title, null: false
      t.text :body, null: false
      t.references :author, foreign_key: {to_table: :users}, null: false
      t.datetime :published_at

      t.timestamps
    end

    create_join_table :articles, :tracks do |t|
      t.index [:article_id, :track_id]
    end

    add_foreign_key :articles_tracks, :articles
    add_foreign_key :articles_tracks, :tracks
  end
end
