class AddInternalNotesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :internal_notes, :text
  end
end
