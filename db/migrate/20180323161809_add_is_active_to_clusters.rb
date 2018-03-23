class AddIsActiveToClusters < ActiveRecord::Migration[5.1]
  def change
    add_column :clusters, :is_active, :boolean, default: true, null: false
  end
end
