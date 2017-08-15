# This migration comes from cmsimple (originally 20120328174339)
class AddMetaInfoToCmsimplePages < ActiveRecord::Migration[4.2]
  def change
    change_table :cmsimple_pages do |t|
      t.string :keywords
      t.text   :description
      t.string :browser_title
    end
  end
end
