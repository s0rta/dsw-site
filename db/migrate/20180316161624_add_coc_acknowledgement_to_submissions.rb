class AddCocAcknowledgementToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :coc_acknowledgement, :boolean, default: false, null: false
  end
end
