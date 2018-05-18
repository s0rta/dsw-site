class AddFulltextIndicesToSubmissions < ActiveRecord::Migration[4.2]
  disable_ddl_transaction!

  def up
    execute <<-SQL unless index_exists?(:submissions, name: :fulltext_submissions_title_english)
      CREATE INDEX CONCURRENTLY fulltext_submissions_title_english
        ON submissions
        USING gin(to_tsvector('english', title));
    SQL
    execute <<-SQL unless index_exists?(:submissions, name: :fulltext_submissions_description_english)
      CREATE INDEX CONCURRENTLY fulltext_submissions_description_english
        ON submissions
        USING gin(to_tsvector('english', description));
    SQL
  end

  def down
    remove_index :submissions, name: :fulltext_submissions_title_english
    remove_index :submissions, name: :fulltext_submissions_description_english
  end
end
