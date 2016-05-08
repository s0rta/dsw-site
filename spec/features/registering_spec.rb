require 'spec_helper'

feature 'Registering to attend' do

  before do
    @track = Track.create! name: 'Bizness'
    FeatureToggler.activate_registration!
  end

  scenario 'Registering to attend with LinkedIn' do
    pending
    visit '/registration/new'
    click_link 'Create an account'
    click_link 'Sign in with Linkedin'
    find('button', text: 'Get Started', visible: true).click
    select 'Bizness', from: 'registration_track_id'
    fill_in 'registration_primary_role', with: 'Developer'
    fill_in 'registration_zip', with: '12345'
    select 'Male', from: 'registration_gender'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'registration_contact_email', with: 'test@example.com'
    click_button 'Submit'
    expect(page).to have_content('Thanks for registering!')
    click_link 'Next Step: Build Your Schedule'
    expect(current_path).to eq('/schedule')
  end

  scenario 'Registering to attend with a separate account' do
    pending
    visit '/registration/new'
    click_link 'Create an account'
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password'
    click_button 'Sign Up'
    find('button', text: 'Get Started', visible: true).click
    select 'Bizness', from: 'registration_track_id'
    fill_in 'registration_primary_role', with: 'Developer'
    fill_in 'registration_zip', with: '12345'
    select 'Male', from: 'registration_gender'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'registration_contact_email', with: 'test@example.com'
    click_button 'Submit'
    expect(page).to have_content('Thanks for registering!')
    click_link 'Next Step: Build Your Schedule'
    expect(current_path).to eq('/schedule')
  end

  scenario 'User tries to register when registrations are closed' do
    pending
    FeatureToggler.deactivate_registration!
    visit '/registration/new'
    expect(page).to have_content('Registration Is Closed')
    expect(current_path).to eq('/registration/closed')
  end

end
