class ChangeVenuesToMatchGoogleForms < ActiveRecord::Migration[5.1]
  def change
    rename_column :venues, :capacity, :seated_capacity
    add_column :venues, :standing_capacity, :integer, default: 0
    add_column :venues, :av_capabilities, :string
  end
end
