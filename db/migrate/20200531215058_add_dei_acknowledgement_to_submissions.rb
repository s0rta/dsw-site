class AddDeiAcknowledgementToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :dei_acknowledgement, :boolean, default: false, null: false
  end
end
