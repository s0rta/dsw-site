require 'spec_helper'

describe 'Schedule API', type: :request do

  let(:submitter) { User.create!(name: 'Test User', email: 'test@example.com') }
  let(:track) { Track.create!(name: 'Tech') }
  let!(:submission) do
    submitter.submissions.create!(track_id: track.id,
                                  title: 'Hello!',
                                  description: 'Hey there!',
                                  contact_email: 'test@example.com')
  end

  it 'allows retrieval of schedule data via a simple JSON API' do
    submission.update_attributes({ start_day: 1, end_day: 1 }, as: :admin)
    submission.update_column(:state, 'confirmed')
    get '/schedule.json'
    json = ActiveSupport::JSON.decode(response.body)
    expect(json.size).to eq(1)
    expect(json.first).to eq({
      "title"=>"Hello!",
      "description"=>"Hey there!",
      "format"=>nil,
      "track_name"=>"Tech",
      "venue_name"=>nil,
      "venue_address"=>nil,
      "start_datetime"=>"2014-09-15T00:00:00Z",
      "end_datetime"=>"2014-09-15T00:00:00Z",
      "registrant_count"=>0 })
  end

end
