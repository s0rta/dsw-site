class CreateAuthorships < ActiveRecord::Migration[5.2]
  def up
    create_table :authorships do |t|
      t.references :article, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_displayed, default: true, null: false
      t.timestamps
    end

    Article.find_each do |a|
      a.update_attribute(:author_ids, [a.author.id])
    end

    remove_column :articles, :author_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
