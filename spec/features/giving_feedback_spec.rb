require 'spec_helper'

feature 'Giving feedback on a session' do

  let(:user) do
    create(:user, email: 'test@example.com',
                  password: 'password')
  end

  let(:track) do
    create(:track, name: 'Founder',
                   is_submittable: true)
  end

  let(:submission) do
    create(:submission,
           submitter: user,
           title: 'I am a session',
           description: 'interesting stuff',
           track: track,
           contact_email: 'test@example.com',
           state: 'confirmed',
           coc_acknowledgement: true,
           year: AnnualSchedule.current.year,
           start_day: 2,
           start_hour: 10,
           end_day: 2,
           end_hour: 11.5)
  end

  describe 'when in the week' do
    let!(:registration) do
      create(:registration, user: user,
                            year: AnnualSchedule.current.year)
    end

    before do
      travel_to AnnualSchedule.current.week_start_at + 1.day
    end

    scenario 'a user provides feedback for a session when already signed in and registered' do
      login_as user, scope: :user

      submission

      visit '/schedule/monday'
      click_on(class: 'ScheduledSession')

      select 'Good', from: 'Please rate this session'
      fill_in 'Comments', with: 'here are my comments'
      click_button 'Share Feedback'
      expect(page).to have_content('Thank you for submitting feedback!')

      expect(submission.feedback.count).to eq 1
      expect(submission.feedback.first.rating).to eq 3
      expect(submission.feedback.first.comments).to eq 'here are my comments'
    end

    scenario 'a user cannot provide feedback if not signed in' do
      submission

      visit '/schedule/monday'
      click_on(class: 'ScheduledSession')

      expect(page).to_not have_content 'Please rate this session'
      # add something here to ensure 1 feedback/session
    end

    after do
      travel_back
    end
  end

  describe 'in years after the current one' do
    let!(:registration) do
      create(:registration, user: user,
                            year: AnnualSchedule.current.year)
    end

    before do
      travel_to AnnualSchedule.current.week_start_at + 1.day + 1.year
    end

    scenario 'A user can still provide feedback for a session' do
      login_as user, scope: :user

      visit "/schedule/#{submission.year}/monday"
      click_on(class: 'ScheduledSession')

      expect(page).to have_content 'Please rate this session'
    end
  end

  describe 'when feedback form is unavailable' do
    let!(:registration) do
      create(:registration, user: user,
                            year: AnnualSchedule.current.year)
    end

    before do
      travel_to AnnualSchedule.current.registration_open_at + 1.day
    end

    scenario 'User cannot provide feedback before week start' do
      login_as user, scope: :user

      submission

      visit '/schedule'
      click_on(class: 'ScheduledSession')

      expect(page).not_to have_content 'Please rate this session'
    end

    after do
      travel_back
    end
  end
end
