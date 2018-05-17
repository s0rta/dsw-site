class CreateFeedback < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback do |t|
      t.integer :rating
      t.text :comments

      t.belongs_to :submission, foreign_key: true, index: true

      t.timestamps
    end
  end
end
