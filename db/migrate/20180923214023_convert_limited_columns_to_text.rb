class ConvertLimitedColumnsToText < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :description, :text
    change_column :submissions, :title, :text
  end
end
