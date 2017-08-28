class CreateSponsorships < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsorships do |t|
      t.string :name, null: false
      t.string :logo
      t.string :link_href, null: false
      t.text :description
      t.integer :year, null: false
      t.string :level, null: false
      t.references :track

      t.timestamps
    end
  end
end
