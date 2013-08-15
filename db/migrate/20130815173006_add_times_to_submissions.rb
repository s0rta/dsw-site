class AddTimesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :start_hour, :integer
    add_column :submissions, :end_hour, :integer
  end
end
