class AddFulltextIndexOnCompanyName < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def up
    execute <<-SQL unless index_exists?(:users, name: :fulltext_companies_name_english)
      CREATE INDEX CONCURRENTLY fulltext_companies_name_english
        ON companies
        USING gin(to_tsvector('english', name));
    SQL
  end

  def down
    drop_index :companies, name: :fulltext_companies_name_english
  end
end
