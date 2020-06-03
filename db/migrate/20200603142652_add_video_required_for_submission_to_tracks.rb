class AddVideoRequiredForSubmissionToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :video_required_for_submission, :boolean, default: false, null: false
  end
end
