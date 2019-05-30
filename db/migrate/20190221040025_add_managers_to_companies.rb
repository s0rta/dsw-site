class AddManagersToCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies_users do |t|
      t.belongs_to :company, index: true
      t.belongs_to :user, index: true
    end
  end
end
