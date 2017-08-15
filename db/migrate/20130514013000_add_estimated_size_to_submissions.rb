class AddEstimatedSizeToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :estimated_size, :string
  end
end
