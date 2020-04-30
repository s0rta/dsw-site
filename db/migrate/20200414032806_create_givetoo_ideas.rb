class CreateGivetooIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :givetoo_ideas do |t|
      t.datetime :expires_at
      t.references :user
      t.text :description
      t.text :kind
      t.text :title
      t.text :website_url
      t.timestamps
    end
  end
end
