class AddInternalNotesToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :internal_notes, :text
  end
end
