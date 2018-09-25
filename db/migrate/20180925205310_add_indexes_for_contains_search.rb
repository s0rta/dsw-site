class AddIndexesForContainsSearch < ActiveRecord::Migration[5.1]
  def change
    enable_extension('pg_trgm') unless extension_enabled?('pg_trgm')
    add_index :companies, :name, using: :gin, opclass: :gin_trgm_ops, name: 'idx_companies_name_contains'
    add_index :users, :name, using: :gin, opclass: :gin_trgm_ops, name: 'idx_users_name_contains'
    add_index :users, :email, using: :gin, opclass: :gin_trgm_ops, name: 'idx_users_email_contains'
    add_index :submissions, :title, using: :gin, opclass: :gin_trgm_ops, name: 'idx_submissions_title_contains'
    add_index :submissions, :description, using: :gin, opclass: :gin_trgm_ops, name: 'idx_submissions_description_contains'
  end
end
