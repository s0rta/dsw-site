class AddRegistrantCountToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :registrant_count, :integer, default: 0, null: false
    Submission.reset_column_information
    Submission.find_each do |s|
      Submission.reset_counters s.id, :session_registrations
    end
  end
end
