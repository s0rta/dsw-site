class AddSubmissionIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :submission, foreign_key: true
  end
end
