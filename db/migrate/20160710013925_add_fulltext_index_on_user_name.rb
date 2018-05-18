class AddFulltextIndexOnUserName < ActiveRecord::Migration[4.2]
  disable_ddl_transaction!

  def up
    execute <<-SQL unless index_exists?(:users, name: :fulltext_users_name_english)
      CREATE INDEX CONCURRENTLY fulltext_users_name_english
        ON users
        USING gin(to_tsvector('english', name));
    SQL
  end

  def down
    remove_index :users, name: :fulltext_users_name_english
  end
end
