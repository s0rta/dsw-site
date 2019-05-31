class AddHeaderImageToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :header_image, :string
  end
end
