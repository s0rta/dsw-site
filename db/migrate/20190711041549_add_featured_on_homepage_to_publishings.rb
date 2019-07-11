class AddFeaturedOnHomepageToPublishings < ActiveRecord::Migration[5.2]
  def change
    add_column :publishings, :featured_on_homepage, :boolean, default: false, null: false
  end
end
