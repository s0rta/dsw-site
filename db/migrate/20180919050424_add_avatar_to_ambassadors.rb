class AddAvatarToAmbassadors < ActiveRecord::Migration[5.1]
  def change
    add_column :ambassadors, :avatar, :string
  end
end
