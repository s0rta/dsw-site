require 'spec_helper'

feature 'Creating a submission' do

  let(:homepage) { Cmsimple::Page.create is_root: true, title: 'Home', template: 'default' }

  before { homepage.publish! }

  scenario 'User submits a new idea' do
    visit '/'
    click_link 'Submit a Session'
    click_link 'Sign in with LinkedIn to continue'
    select 'Panel', from: 'submission_format'
    next_buttons = all(:css, 'button', text: 'Next')
    next_buttons[0].click
    fill_in 'submission_title', with: 'Some talk'
    fill_in 'submission_description', with: 'I am going to give a talk.'
    next_buttons[1].click
    select 'Monday', from: 'submission_day'
    fill_in 'submission_location', with: 'City Hall'
    select 'Evening', from: 'submission_time_range'
    next_buttons[2].click
    fill_in 'submission_notes', with: 'I want to do a panel with more people.'
    next_buttons[3].click
    fill_in 'submission_contact_email', with: 'test2@example.com'
    click_button 'Submit'
  end

end
