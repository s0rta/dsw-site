class AddCompanyIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :company, foreign_key: true
  end
end
