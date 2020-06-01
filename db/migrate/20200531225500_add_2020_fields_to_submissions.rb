class Add2020FieldsToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :proposal_video_url, :string
    add_column :submissions, :preferred_length, :string
  end
end
