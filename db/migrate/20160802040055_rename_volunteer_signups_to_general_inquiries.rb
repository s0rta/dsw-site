class RenameVolunteerSignupsToGeneralInquiries < ActiveRecord::Migration
  def change
    rename_table :volunteer_signups, :general_inquiries
  end
end
