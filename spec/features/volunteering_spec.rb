require 'spec_helper'

feature 'Signing up to volunteer' do

  before do
    @track = Track.new name: 'Bizness'
    @track.save!
    FeatureToggler.activate_volunteership!
  end

  let(:venue) do
    create(:venue, name: 'Hooli HQ')
  end

  let!(:user) do
    create(:user, email: 'test@example.com', password: 'password')
  end

  let!(:monday_shift) do
    VolunteerShift.create! name: 'Monday Morning', day: 2, start_hour: 10, end_hour: 14, venue: venue
  end

  let!(:tuesday_shift) do
    VolunteerShift.create! name: 'Tuesday Afternoon', day: 3, start_hour: 2, end_hour: 16
  end

  scenario 'User tries to access volunteer form when volunteership is closed' do
    FeatureToggler.deactivate_volunteership!
    login_as user, scope: :user
    visit '/volunteer/signup'
    expect(page).to have_content("Volunteer signup for #{Date.today.year} is currently closed")
  end

  scenario 'User signs up to volunteer when already signed in' do
    login_as user, scope: :user
    visit '/dashboard'
    click_link 'Volunteer'
    click_link 'Sign up to volunteer'
    fill_in 'volunteership_mobile_phone_number', with: '000-555-1212'
    fill_in 'volunteership_affiliated_organization', with: 'Globex Corporation'
    select2 'Monday Morning', from: 'Please select the shifts you would like to sign up for'
    select2 'Tuesday Afternoon', from: 'Please select the shifts you would like to sign up for'
    click_button 'Submit'
    expect(page). to have_content('Thanks for volunteering! You will receive a confirmation e-mail shortly.')
  end

  scenario 'User registers to volunteer after being prompted to sign in' do
    visit '/volunteer/signup'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    click_button 'Sign In'
    select2 'Monday Morning', from: 'Please select the shifts you would like to sign up for'
    select2 'Tuesday Afternoon', from: 'Please select the shifts you would like to sign up for'
    fill_in 'volunteership_mobile_phone_number', with: '000-555-1212'
    fill_in 'volunteership_affiliated_organization', with: 'Globex Corporation'
    click_button 'Submit'
    expect(page). to have_content('Thanks for volunteering! You will receive a confirmation e-mail shortly.')

    expect(last_email_sent).to deliver_to('test@example.com')
    expect(last_email_sent).to have_subject('Thanks for volunteering to help out with Denver Startup Week!')
  end

  scenario 'User registers to volunteer using an organiation deeplink'

  scenario 'User should be able to view/edit their shift selections' do
    login_as user, scope: :user
    visit '/dashboard'
    click_link 'Volunteer'
    click_link 'Sign up to volunteer'
    fill_in 'volunteership_mobile_phone_number', with: '000-555-1212'
    fill_in 'volunteership_affiliated_organization', with: 'Globex Corporation'
    select2 'Monday Morning', from: 'Please select the shifts you would like to sign up for'
    click_button 'Submit'
    expect(page).to have_content('Thanks for volunteering! You will receive a confirmation e-mail shortly.')
    expect(page).to have_content('YOUR VOLUNTEER SHIFTS')
    expect(page).to have_content('Monday Morning (10:00am to 2:00pm at Hooli HQ)')
    click_link 'Change my volunteer shifts'
    unselect 'Monday Morning', from: 'Please select the shifts you would like to sign up for'
    select2 'Tuesday Afternoon', from: 'Please select the shifts you would like to sign up for'
    click_button 'Submit'
    expect(page).to have_content('Your changes have been saved. You will receive a confirmation e-mail shortly.')
    expect(page).to have_content('YOUR VOLUNTEER SHIFTS')
    expect(page).to have_content('Tuesday Afternoon')

    expect(last_email_sent).to deliver_to('test@example.com')
    expect(last_email_sent).to deliver_from('Denver Startup Week <volunteer@denverstartupweek.org>')
    expect(last_email_sent).to have_subject('Confirming your updated volunteer shifts for Denver Startup Week')
  end
end
