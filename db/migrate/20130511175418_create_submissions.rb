class CreateSubmissions < ActiveRecord::Migration[4.2]
  def change
    create_table :submissions do |t|
      t.references :submitter
      t.references :track
      t.string :format
      t.string :location
      t.string :day
      t.string :time_range
      t.string :title
      t.text :description
      t.text :notes

      t.timestamps
    end
    add_index :submissions, :submitter_id
    add_index :submissions, :track_id
  end
end
