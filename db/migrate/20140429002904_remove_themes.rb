class RemoveThemes < ActiveRecord::Migration[4.2]
  def up
    drop_table :themes
    remove_column :submissions, :theme_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
