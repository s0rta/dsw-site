class AddDescriptionToClusters < ActiveRecord::Migration[4.2]
  def change
    add_column :clusters, :description, :text
  end
end
