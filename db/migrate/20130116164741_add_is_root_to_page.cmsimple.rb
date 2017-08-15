# This migration comes from cmsimple (originally 20120323200439)
class AddIsRootToPage < ActiveRecord::Migration[4.2]
  def change
    add_column :cmsimple_pages, :is_root, :boolean, default: false
  end
end
