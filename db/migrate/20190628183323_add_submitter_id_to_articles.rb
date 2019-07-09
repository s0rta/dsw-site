class AddSubmitterIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :submitter, foreign_key: { to_table: :users }
  end
end
