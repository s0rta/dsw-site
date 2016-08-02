class AddProposedUpdatesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :proposed_updates, :json
  end
end
