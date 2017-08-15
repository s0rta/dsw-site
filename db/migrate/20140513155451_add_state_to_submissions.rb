class AddStateToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :state, :string
  end
end
