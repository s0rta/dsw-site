class PopulateExistingYearOnSubmissions < ActiveRecord::Migration

  def up
    Submission.update_all 'year = 2013'
  end

  def down
    Submission.update_all 'year = NULL'
  end

end
