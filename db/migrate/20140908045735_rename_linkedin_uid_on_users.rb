class RenameLinkedinUidOnUsers < ActiveRecord::Migration[4.2]
  def up
    rename_column :users, :linkedin_uid, :uid
  end

  def down
    rename_column :users, :uid, :linkedin_uid
  end
end
