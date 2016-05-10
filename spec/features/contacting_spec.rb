require 'spec_helper'

feature 'Filling out the contact form' do

  before do
    ENV['VOLUNTEER_SIGNUP_EMAIL_RECIPIENTS'] = 'volunteer@example.com'
  end

  scenario 'User submits a contact request' do
    visit '/contact' # Can't click on the element for some reason
    fill_in 'Name', with: 'Some person'
    fill_in 'E-mail Address', with: 'test@example.com'
    fill_in 'What are you interested in?', with: 'Helping out'
    fill_in 'Any additional notes?', with: 'Nope'
    click_button 'Submit'
    expect(page).to have_button('Thanks! We will be in touch shortly')

    # Saved to DB
    expect(VolunteerSignup.count).to eq(1)
    expect(VolunteerSignup.last.contact_email).to eq('test@example.com')
    expect(VolunteerSignup.last.contact_name).to eq('Some person')
    expect(VolunteerSignup.last.interest).to eq('Helping out')
    expect(VolunteerSignup.last.notes).to eq('Nope')

    # Confirmation to volunteers box
    email = ActionMailer::Base.deliveries.find { |e| e.to.include?('volunteer@example.com')}
    expect(email.subject).to eq('Someone has volunteered to help out with DSW')
  end

end
