class PopulateSubmissionsEndDay < ActiveRecord::Migration[4.2]
  def up
    Submission.update_all 'end_day = start_day'
  end

  def down
    # No-op
  end
end
