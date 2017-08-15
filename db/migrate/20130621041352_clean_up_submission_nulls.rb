class CleanUpSubmissionNulls < ActiveRecord::Migration[4.2]
  def up
    Submission.where(format: 'Something else entirely').update_all(format: nil)
    Submission.where(day: 'Not sure / don\'t care ').update_all(day: nil)
    Submission.where(time_range: 'Not sure / don\'t care').update_all(time_range: nil)
  end

  def down
  end
end
