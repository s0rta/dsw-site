require 'spec_helper'

feature 'Creating a submission' do

  before do
    @chair = User.create! name: 'Mr. Chairman', email: 'chair@example.com', password: 'passsword'
    @track = Track.new name: 'Bizness', is_submittable: true
    @track.chairs << @chair
    @track.save!
    FeatureToggler.activate_submission!
  end

  scenario 'User submits a new idea' do
    visit '/panel-picker/mine' # Can't click on the homepage for some reason
    click_on 'Register for an account'
    fill_in 'Name', with: 'New Guy'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password', match: :prefer_exact

    click_on 'Sign Up'
    click_on 'Submit a New Proposal'
    select 'Bizness', from: 'submission_track_id'
    fill_in 'submission_title', with: 'Some talk'
    fill_in 'submission_description', with: 'I am going to give a talk.'
    fill_in 'submission_notes', with: 'Please pick my talk.'
    fill_in 'submission_contact_email', with: 'test2@example.com'
    click_button 'Submit'
    expect(page).to have_content('Thanks!')

    # See it in the list
    expect(page).to have_content('Some talk (Bizness)')

    # Confirmation to track chair
    email = ActionMailer::Base.deliveries.detect { |e| e.to.include?('chair@example.com') }
    expect(email.subject).to eq('A new DSW submission has been received for the Bizness track')

    # Confirmation to submitter
    email = ActionMailer::Base.deliveries.detect { |e| e.to.include?('test2@example.com') }
    expect(email.subject).to eq('Thanks for submitting a session proposal for Denver Startup Week!')
  end

  scenario 'User tries to submit a new idea when submissions are closed' do
    FeatureToggler.deactivate_submission!
    visit '/panel-picker/submit'
    expect(page).to have_content("Session submissions for #{Date.today.year} are currently closed")
    expect(current_path).to eq('/panel-picker/submissions_closed')

    visit '/panel-picker/mine'
    click_on 'Register for an account'
    fill_in 'Name', with: 'New Guy'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password', match: :prefer_exact

    click_on 'Sign Up'
    expect(page).to have_no_link('Submit a New Proposal')
  end

  scenario 'User tries to submit a new idea but fails to create an account' do
    User.create! name: 'Here First', email: 'test@example.com', password: 'password', password_confirmation: 'password'
    visit '/panel-picker/mine'
    click_on 'Register for an account'
    fill_in 'Name', with: 'New Guy'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password', match: :prefer_exact
    click_on 'Sign Up'
    expect(page).to have_content('Email has already been taken')
  end

  scenario 'User edits an existing submission' do
    visit '/panel-picker/mine' # Can't click on the homepage for some reason
    click_on 'Register for an account'
    fill_in 'Name', with: 'New Guy'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password', match: :prefer_exact

    click_on 'Sign Up'
    click_on 'Submit a New Proposal'
    select 'Bizness', from: 'submission_track_id'
    fill_in 'submission_title', with: 'Some talk'
    fill_in 'submission_description', with: 'I am going to give a talk.'
    fill_in 'submission_notes', with: 'Please pick my talk.'
    fill_in 'submission_contact_email', with: 'test2@example.com'
    click_button 'Submit'

    click_on 'Propose Update'
    fill_in 'submission_title', with: 'Updated talk'
    fill_in 'submission_description', with: 'Here is my udpated idea'
    fill_in 'submission_notes', with: 'I have even more things to say now.'
    click_button 'Submit'

    expect(page).to have_content 'Some talk'
    expect(page).to have_content 'Your changes have been submitted'

    Submission.last.promote_updates
    visit page.current_path

    expect(page).to have_content 'Updated talk'
    expect(page).to_not have_content 'Some talk'
  end

end
