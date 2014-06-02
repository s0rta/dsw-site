require 'spec_helper'

feature 'Creating a submission' do

  let(:homepage) { Cmsimple::Page.create is_root: true, title: 'Home', template: 'landing_2014' }

  before do
    homepage.publish!
    @chair = User.create! name: 'Mr. Chairman', email: 'chair@example.com'
    @track = Track.new name: 'Bizness'
    @track.chairs << @chair
    @track.save!
    FeatureToggler.activate_submission!
  end

  scenario 'User submits a new idea' do
    visit '/panel-picker/submit'
    click_link 'Sign in with LinkedIn to continue'
    find('button', text: 'Get Started', visible: true).click
    select 'Panel', from: 'submission_format'
    select 'Bizness', from: 'submission_track_id'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'submission_title', with: 'Some talk'
    fill_in 'submission_description', with: 'I am going to give a talk.'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'submission_location', with: 'City Hall'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'submission_notes', with: 'I want to do a panel with more people.'
    all('button', text: 'Next', visible: true).last.click
    fill_in 'submission_contact_email', with: 'test2@example.com'
    click_button 'Submit'
    expect(page).to have_content('Thanks!')

    # Confirmation to track chair
    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq('A new DSW submission has been received for the Bizness track')
    expect(email.to).to include('chair@example.com')

    # Confirmation to submitter
    email = ActionMailer::Base.deliveries.last
    expect(email.subject).to eq('Thanks for submitting a session proposal for Denver Startup Week!')
    expect(email.to).to include('test2@example.com')
  end

  scenario 'User tries to submit a new idea when submissions are closed' do
    FeatureToggler.deactivate_submission!
    visit '/panel-picker/submit'
    expect(page).to have_content('Session Submissions Are Now Closed')
    expect(current_path).to eq('/panel-picker/submissions_closed')
  end

end
