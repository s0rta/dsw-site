class AddFulltextIndicesToVenues < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    execute <<-SQL unless index_exists?(:articles, name: :fulltext_venues_name_english)
      CREATE INDEX CONCURRENTLY fulltext_venues_name_english
        ON venues
        USING gin(to_tsvector('english', name));
    SQL
  end

  def down
    remove_index :venues, name: :fulltext_venues_name_english
  end
end
