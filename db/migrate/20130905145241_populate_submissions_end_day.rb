class PopulateSubmissionsEndDay < ActiveRecord::Migration
  def up
    Submission.update_all 'end_day = start_day'
  end

  def down
    # No-op
  end
end
