require 'spec_helper'

feature 'Signing up to volunteer' do

  before do
    @track = Track.new name: 'Bizness'
    @track.save!
    FeatureToggler.activate_volunteership!
  end

  let!(:user) do
    User.create! name: 'Test User', email: 'test@example.com', password: 'password'
  end

  let!(:monday_shift) do
    VolunteerShift.create! name: 'Monday Morning', day: 2, start_hour: 10, end_hour: 14
  end

  let!(:tuesday_shift) do
    VolunteerShift.create! name: 'Tuesday Afternoon', day: 3, start_hour: 2, end_hour: 16
  end

  scenario 'User tries to access volunteer form when volunteership is closed' do
    pending
    FeatureToggler.deactivate_volunteership!
    visit '/volunteer/signup'
    expect(page).to have_content("Volunteer signup for #{Date.today.year} is currently closed")
    expect(current_path).to eq('/volunteer/signup-closed')
  end

  scenario 'User signs up to volunteer when already signed in' do
    login_as user, scope: :user
    visit '/volunteer/signup'
    select 'Monday Morning', from: 'volunteership_available_shift_ids'
    select 'Tuesday Afternoon', from: 'volunteership_available_shift_ids'
    fill_in 'volunteership_mobile_phone_number', with: '000-555-1212'
    fill_in 'volunteership_affiliated_organization', with: 'Globex Corporation'
    click_button 'Submit'
    expect(page). to have_content('Thanks for volunteering! We will reach out to you shortly to confirm details.')
  end

  scenario 'User votes for a session after being prompted to sign in' do
    visit '/volunteer/signup'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    click_button 'Sign In'
    select 'Monday Morning', from: 'volunteership_available_shift_ids'
    select 'Tuesday Afternoon', from: 'volunteership_available_shift_ids'
    fill_in 'volunteership_mobile_phone_number', with: '000-555-1212'
    fill_in 'volunteership_affiliated_organization', with: 'Globex Corporation'
    click_button 'Submit'
    expect(page). to have_content('Thanks for volunteering! We will reach out to you shortly to confirm details.')
  end
end
