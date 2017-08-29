class AddCompanyIdToSubmissions < ActiveRecord::Migration[5.1]
  def change
    change_table :submissions do |t|
      t.references :company, index: true, foreign_key: true
    end
  end
end
