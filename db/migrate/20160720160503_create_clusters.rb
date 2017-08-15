class CreateClusters < ActiveRecord::Migration[4.2]
  def change
    create_table :clusters do |t|
      t.string :name

      t.timestamps null: false
    end
    change_table :submissions do |t|
      t.references :cluster, index: true
    end
  end
end
