require 'spec_helper'

feature 'Content-only pages' do
  scenario 'the sponsors page' do
    visit '/'
    find('#menu-icon').click
    click_link 'Sponsors'
    expect(page).to have_content("OUR #{Date.today.year} SPONSORS")
  end
end
