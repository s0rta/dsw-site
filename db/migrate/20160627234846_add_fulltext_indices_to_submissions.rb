class AddFulltextIndicesToSubmissions < ActiveRecord::Migration
  disable_ddl_transaction!

  def up
    execute <<-EOF unless index_exists?(:submissions, name: :fulltext_submissions_title_english)
      CREATE INDEX CONCURRENTLY fulltext_submissions_title_english
        ON submissions
        USING gin(to_tsvector('english', title));
    EOF
    execute <<-EOF unless index_exists?(:submissions, name: :fulltext_submissions_description_english)
      CREATE INDEX CONCURRENTLY fulltext_submissions_description_english
        ON submissions
        USING gin(to_tsvector('english', description));
    EOF
  end

  def down
    drop_index :submissions, name: :fulltext_submissions_title_english
    drop_index :submissions, name: :fulltext_submissions_description_english
  end
end
