class AddSessionRegistrationsCountToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :session_registrations_count, :integer, default: 0
    Submission.reset_column_information
    Submission.find_each do |s|
      Submission.reset_counters s.id, :session_registrations
    end
  end
end
