class AddIsSubmittableToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :is_submittable, :boolean, default: false, null: false
    Track.reset_column_information
    Track.where(name: %w(Designer Developer Product Growth Founder Maker)).update_all(is_submittable: true)
  end
end
