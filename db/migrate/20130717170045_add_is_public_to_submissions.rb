class AddIsPublicToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :is_public, :boolean, default: true, null: false
  end
end
