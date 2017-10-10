class DropCmsimpleTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :cmsimple_images
    drop_table :cmsimple_versions
    drop_table :cmsimple_paths
    drop_table :cmsimple_pages
  end
end
