class AddFieldsToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :volunteers_needed, :integer
    add_column :submissions, :budget_needed, :integer
  end
end
