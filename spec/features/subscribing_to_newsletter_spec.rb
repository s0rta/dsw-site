require 'spec_helper'

feature 'Subscribing to the newsletter' do
  scenario 'from the page footer' do
    visit '/'
    fill_in 'Email Address', with: 'test@example.com'
    click_button 'Subscribe to Updates'
    expect(page).to have_button('Thanks!')
  end
end
