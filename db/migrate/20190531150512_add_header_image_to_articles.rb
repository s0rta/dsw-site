class AddHeaderImageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :header_image, :string
  end
end
