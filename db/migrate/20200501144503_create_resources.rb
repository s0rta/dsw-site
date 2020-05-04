class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :image
      t.references :company, index: true, null: false
      t.string :description, null: false
      t.string :contact_information, null: false
      t.string :website
      t.date :expiration_date
      t.references :industry_type, index: true
      t.references :user, index: true, null: false

      t.timestamps
    end

    create_join_table :resources, :support_areas do |t|
      t.index %i[resource_id support_area_id], name: :idx_resource_support_area
    end

    add_foreign_key :resources_support_areas, :resources
    add_foreign_key :resources_support_areas, :support_areas
  end
end
