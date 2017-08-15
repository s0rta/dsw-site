class AddYearToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :year, :integer
  end
end
