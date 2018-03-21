class AddCompanyToGeneralInquiries < ActiveRecord::Migration[5.1]
  def change
    add_column :general_inquiries, :company, :string
  end
end
