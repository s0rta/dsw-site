class AddSlidesUrlAndVideoUrlToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :slides_url, :string
    add_column :submissions, :video_url, :string
  end
end
