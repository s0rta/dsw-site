class AddIsPublicToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :is_public, :boolean, default: true, null: false
  end
end
