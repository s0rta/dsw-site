class AddNoindexToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :noindex, :boolean, default: false, null: false
  end
end
