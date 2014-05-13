class AddStateToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :state, :string
  end
end
