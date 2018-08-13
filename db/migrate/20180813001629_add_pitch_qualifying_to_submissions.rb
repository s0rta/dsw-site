class AddPitchQualifyingToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :pitch_qualifying, :boolean, default: false, null: false
  end
end
