class AddColorToSupportArea < ActiveRecord::Migration[6.0]
  def change
    add_column :support_areas, :color, :string
  end
end
