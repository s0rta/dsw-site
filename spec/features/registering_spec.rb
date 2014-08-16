require 'spec_helper'

feature 'Registering to attend' do

  let(:homepage) { Cmsimple::Page.create is_root: true, title: 'Home', template: 'landing_2014' }

  before do
    homepage.publish!
    @track = Track.create! name: 'Bizness'
    FeatureToggler.activate_registration!
  end

  scenario '' do
    visit '/registration/new'
    click_link 'Sign in with LinkedIn to continue'
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
    FeatureToggler.deactivate_registration!
    visit '/registration/new'
    expect(page).to have_content('Registration Is Closed')
    expect(current_path).to eq('/registration/closed')
  end

end
