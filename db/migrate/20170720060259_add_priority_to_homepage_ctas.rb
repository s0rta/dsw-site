class AddPriorityToHomepageCtas < ActiveRecord::Migration
  def change
    add_column :homepage_ctas, :priority, :integer, default: 0, null: false
  end
end
