class RenameCompanyToCompanyNameOnRegistrations < ActiveRecord::Migration[5.1]
  def change
    rename_column :registrations, :company, :company_name
  end
end
