class AddDescriptionToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :description, :text
  end
end
