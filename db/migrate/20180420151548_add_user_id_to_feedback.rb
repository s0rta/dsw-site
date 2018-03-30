class AddUserIdToFeedback < ActiveRecord::Migration[5.1]
  def change
    change_table :feedback do |t|
      t.references :user, index: true, foreign_key: true
    end
  end
end
