class AddLiveStreamUrlToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :live_stream_url, :string
  end
end
