class AddTrackToHomepageCtas < ActiveRecord::Migration[5.1]
  def change
    add_reference :homepage_ctas, :track, foreign_key: true
  end
end
