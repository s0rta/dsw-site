class AddThemeIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :theme_id, :integer
  end
end
