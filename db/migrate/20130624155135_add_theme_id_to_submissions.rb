class AddThemeIdToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :theme_id, :integer
  end
end
