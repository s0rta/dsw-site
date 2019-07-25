class CreateVenueAdminships < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_adminships do |t|
      t.references :venue, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
