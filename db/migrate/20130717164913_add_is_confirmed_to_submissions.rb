class AddIsConfirmedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :is_confirmed, :boolean, default: false, null: false
  end
end
