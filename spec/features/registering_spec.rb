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
    Track.create! name: 'Founder',
                  is_submittable: true
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
                                  end_hour: 11.5
  end

  before do
    FeatureToggler.activate_registration!
  end

  scenario 'Registering to attend from the schedule page' do
    visit '/schedule'
    click_link 'I am a session'
    click_link 'Add to My Schedule'
    click_link 'Register for an account'
    fill_in 'Name', with: 'Test Registrant'
    fill_in 'E-mail Address', with: 'test2@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password'
    click_button 'Sign Up'
    select 'Male', from: 'registration_gender'
    select '25-34 years old', from: 'registration_age_range'
    select 'Founder', from: 'registration_track_id'
    fill_in 'registration_company', with: 'Example.com'
    fill_in 'registration_primary_role', with: 'Developer'
    fill_in 'registration_zip', with: '12345'
    click_button 'Register'
    expect(page).to have_content('Thanks for registering!')

    # Confirmation to track chair
    email = ActionMailer::Base.deliveries.detect { |e| e.to.include?('test2@example.com') }
    expect(email.subject).to eq("You are registered for Denver Startup Week #{Date.today.year}")

    click_link 'I am a session'
    click_link 'Add to My Schedule'
    click_link 'Remove from My Schedule'
    expect(page).to have_link('Add to My Schedule')
  end

  scenario 'User tries to register when registrations are closed' do
    FeatureToggler.deactivate_registration!
    visit '/registration/new'
    expect(page).to have_content("Registration for #{Date.today.year} is currently closed")
    expect(current_path).to eq('/registration/closed')
  end
end
