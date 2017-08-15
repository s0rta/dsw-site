class AddIsConfirmedToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :is_confirmed, :boolean, default: false, null: false
  end
end
