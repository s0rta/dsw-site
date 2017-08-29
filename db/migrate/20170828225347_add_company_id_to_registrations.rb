class AddCompanyIdToRegistrations < ActiveRecord::Migration[5.1]
  def change
    change_table :registrations do |t|
      t.references :company, index: true, foreign_key: true
    end
  end
end
