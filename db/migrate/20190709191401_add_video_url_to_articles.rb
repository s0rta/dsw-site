class AddVideoUrlToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :video_url, :string
  end
end
