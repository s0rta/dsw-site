class PopulateExistingYearOnSubmissions < ActiveRecord::Migration[4.2]

  def up
    Submission.update_all 'year = 2013'
  end

  def down
    Submission.update_all 'year = NULL'
  end

end
