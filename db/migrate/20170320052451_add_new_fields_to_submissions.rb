class AddNewFieldsToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :open_to_collaborators, :boolean
    add_column :submissions, :from_underrepresented_group, :boolean
    add_column :submissions, :target_audience_description, :text
  end
end
