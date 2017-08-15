class CreateVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :votes do |t|
      t.references :user
      t.references :submission

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :submission_id
  end
end
