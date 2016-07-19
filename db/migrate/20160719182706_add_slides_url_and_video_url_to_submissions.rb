class AddSlidesUrlAndVideoUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :slides_url, :string
    add_column :submissions, :video_url, :string
  end
end
