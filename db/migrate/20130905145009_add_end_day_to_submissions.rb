class AddEndDayToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :end_day, :string
    rename_column :submissions, :day, :start_day
  end
end
