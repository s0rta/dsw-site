class AddHasChildcareToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :has_childcare, :boolean, default: false, null: false
  end
end
