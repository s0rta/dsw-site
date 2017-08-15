class RenameVolunteerSignupsToGeneralInquiries < ActiveRecord::Migration[4.2]
  def change
    rename_table :volunteer_signups, :general_inquiries
  end
end
