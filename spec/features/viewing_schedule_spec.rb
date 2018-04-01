require 'spec_helper'

feature 'Viewing the schedule' do

  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  let(:submitter) do
    create(:user, email: 'test@example.com',
                  password: 'password')
  end

  let(:track) do
    create(:track, name: 'Founder',
                   is_submittable: true)
  end

  let!(:submission) do
    create(:submission,
           submitter: submitter,
           title: 'I am a session',
           description: 'interesting stuff',
           track: track,
           contact_email: 'test@example.com',
           state: 'confirmed',
           start_day: 2,
           start_hour: 10,
           end_day: 2,
           end_hour: 11.5,
           year: AnnualSchedule.current.registration_open_at.year)
  end

  let!(:previous_submission) do
    create(:submission,
           submitter: submitter,
           title: 'I am an older session',
           description: 'interesting stuff',
           track: track,
           contact_email: 'test@example.com',
           state: 'confirmed',
           start_day: 2,
           start_hour: 10,
           end_day: 2,
           end_hour: 11.5,
           year: AnnualSchedule.current.registration_open_at.year - 1)
  end

  describe 'in the current year/registration cycle' do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime + 1.day
    end

    scenario 'Registering to attend from the schedule page' do
      visit '/schedule'
      expect(current_path).to eq('/schedule/2017/monday')
      expect(page).to have_content('I am a session')
      select(1.year.ago.year.to_s, from: 'year')
      expect(current_path).to eq('/schedule/2016/monday')
      expect(page).to have_content('I am an older session')
    end

    scenario 'Link from selection page to schedule page' do
      visit '/program/selection'
      expect(page).to have_content('Looking for examples of past sessions? Check out the 2017 Denver Startup Week schedule HERE')
      click_on('HERE')
      expect(current_path).to eq('/schedule/2017/monday')
    end
  end
end
