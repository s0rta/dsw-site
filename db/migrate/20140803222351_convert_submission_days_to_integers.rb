class ConvertSubmissionDaysToIntegers < ActiveRecord::Migration
  def up
    add_column :submissions, :start_day_integer, :integer
    add_column :submissions, :end_day_integer, :integer
    submission_klass = Class.new(ActiveRecord::Base) do
      self.table_name = 'submissions'
    end
    days_hash = Submission::DAYS.invert
    submission_klass.find_each do |s|
      s.update_column :start_day_integer, days_hash[s.start_day]
      s.update_column :end_day_integer, days_hash[s.end_day]
    end
    remove_column :submissions, :start_day
    remove_column :submissions, :end_day
    rename_column :submissions, :start_day_integer, :start_day
    rename_column :submissions, :end_day_integer, :end_day
  end

  def down
    rename_column :submissions, :start_day, :start_day_integer
    rename_column :submissions, :end_day, :end_day_integer
    add_column :submissions, :start_day, :string
    add_column :submissions, :end_day, :string
    submission_klass = Class.new(ActiveRecord::Base) do
      self.table_name = 'submissions'
    end
    submission_klass.find_each do |s|
      s.update_column :start_day, Submission::DAYS[s.start_day_integer]
      s.update_column :end_day, Submission::DAYS[s.end_day_integer]
    end
    remove_column :submissions, :start_day_integer
    remove_column :submissions, :end_day_integer
  end
end
