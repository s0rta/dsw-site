class AddTimesToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :start_hour, :integer
    add_column :submissions, :end_hour, :integer
  end
end
