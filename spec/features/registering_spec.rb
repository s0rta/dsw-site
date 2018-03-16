require 'spec_helper'

feature 'Registering to attend' do

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
    submitter.submissions.create! title: 'I am a session',
                                  description: 'interesting stuff',
                                  track: track,
                                  contact_email: 'test@example.com',
                                  state: 'confirmed',
                                  start_day: 2,
                                  start_hour: 10,
                                  end_day: 2,
                                  end_hour: 11.5,
                                  coc_acknowledgement: true
  end

  describe 'when registration is open' do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime + 1.day
    end

    before do
      create(:company, name: 'Example.com')
    end

    scenario 'Registering to attend from the schedule page' do
      visit '/schedule'
      click_link 'I am a session'
      click_link 'Add to My Schedule'
      click_link 'Create an account'
      fill_in 'Name', with: 'Test Registrant'
      fill_in 'E-mail Address', with: 'test2@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirm Password', with: 'password'
      click_button 'Sign Up'
      select 'he/him/his', from: 'registration_gender'
      select '25-34 years old', from: 'registration_age_range'
      select 'Founder', from: 'registration_track_id'

      # Use the autocompleter to select
      fill_in 'registration_company_name', with: 'Exa'
      find('.awesomplete li', text: 'Example.com').click

      fill_in 'registration_primary_role', with: 'Developer'
      fill_in 'registration_zip', with: '12345'
      click_button 'Register'
      expect(page).to have_content('Thanks for registering!')

      # Confirmation e-mail
      email = ActionMailer::Base.deliveries.detect { |e| e.to.include?('test2@example.com') }
      expect(email.subject).to eq("You are registered for Denver Startup Week #{Date.today.year}")

      select('Founder Track', from: 'filter')

      click_link 'I am a session'
      click_link 'Add to My Schedule'
      expect(page).not_to have_link('Add to My Schedule')
      click_link 'Remove from My Schedule'
      expect(page).to have_link('Add to My Schedule')

      click_link 'Add to My Schedule'
      visit '/schedule'
      select 'View My Schedule', from: 'filter'
      ical = open(find(:link, 'Add to Outlook/iCal')[:href].gsub('webcal://', 'http://'))
      calendars = Icalendar.parse(ical)
      expect(calendars.first.events.size).to eq(1)
      expect(calendars.first.events.first.summary).to eq('I am a session')
    end
  end

  describe 'when registration is closed' do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime - 1.day
    end

    scenario 'User tries to register when registrations are closed' do
      visit '/registration/new'
      expect(page).to have_content("Registration for #{Date.today.year} is currently closed")
      expect(current_path).to eq('/registration/closed')
    end
  end
end
