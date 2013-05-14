class AddEstimatedSizeToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :estimated_size, :string
  end
end
