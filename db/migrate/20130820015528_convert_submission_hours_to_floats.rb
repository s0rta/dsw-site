class ConvertSubmissionHoursToFloats < ActiveRecord::Migration
  def up
    change_column :submissions, :start_hour, :float
    change_column :submissions, :end_hour, :float
  end

  def down
    change_column :submissions, :start_hour, :integer
    change_column :submissions, :end_hour, :integer
  end
end
