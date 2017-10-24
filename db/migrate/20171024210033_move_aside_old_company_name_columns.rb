class MoveAsideOldCompanyNameColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :submissions, :company_name, :original_company_name
    rename_column :registrations, :company_name, :original_company_name
  end
end
