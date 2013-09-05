class AddEndDayToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :end_day, :string
    rename_column :submissions, :day, :start_day
  end
end
