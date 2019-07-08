class AddFulltextIndicesToArticles < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    execute <<-SQL unless index_exists?(:articles, name: :fulltext_articles_title_english)
      CREATE INDEX CONCURRENTLY fulltext_articles_title_english
        ON articles
        USING gin(to_tsvector('english', title));
    SQL

    execute <<-SQL unless index_exists?(:articles, name: :fulltext_articles_body_english)
      CREATE INDEX CONCURRENTLY fulltext_articles_body_english
        ON articles
        USING gin(to_tsvector('english', body));
    SQL
  end

  def down
    remove_index :articles, name: :fulltext_articles_title_english
    remove_index :articles, name: :fulltext_articles_body_english
  end
end
