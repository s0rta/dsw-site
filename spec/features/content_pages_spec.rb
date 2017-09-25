require 'spec_helper'

feature 'Content-only pages' do
  scenario 'the sponsors page' do
    visit '/'
    click_link 'Sponsors'
    expect(page).to have_content("OUR #{Date.today.year} SPONSORS")
  end

  scenario 'the basecamp page' do
    visit '/basecamp'
    expect(page).to have_content('BASECAMP LAUNCHED BY CHASE FOR BUSINESS')
  end
end
