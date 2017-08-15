class AddProposedUpdatesToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :proposed_updates, :json
  end
end
