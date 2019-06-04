class AddHeaderImageToClusters < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :header_image, :string
  end
end
