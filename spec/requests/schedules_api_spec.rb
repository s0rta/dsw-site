require "spec_helper"

describe "Schedule API", type: :request do
  let(:track) { create(:track, name: "Tech") }
  let!(:submission) do
    create(:submission,
      track_id: track.id,
      title: "Hello!",
      description: "Hey there!",
      start_day: 1,
      end_day: 1,
      state: "confirmed")
  end

  it "allows retrieval of schedule data via a simple JSON API" do
    get "/schedule.json"
    json = ActiveSupport::JSON.decode(response.body)
    expect(json.size).to eq(1)
    expect(json.first).to eq({
      "id" => submission.id,
      "title" => "Hello!",
      "description" => "Hey there!",
      "format" => nil,
      "track_name" => "Tech",
      "venue_name" => nil,
      "venue_address" => nil,
      "start_datetime" => "2017-09-24T00:00:00.000-06:00",
      "end_datetime" => "2017-09-24T00:00:00.000-06:00",
      "registrant_count" => 0,
      "link" => "http://www.example.com/schedule/#{submission.id}-hello"
    })
  end
end
