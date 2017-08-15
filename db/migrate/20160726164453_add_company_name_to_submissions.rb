class AddCompanyNameToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :company_name, :string
  end
end
