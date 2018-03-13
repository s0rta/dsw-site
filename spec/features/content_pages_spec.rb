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

  scenario 'the about page' do
    visit '/about'
    expect(page).to have_content('THE ENTREPRENEURIAL SPIRIT')
  end

  describe 'the contact section' do
    scenario 'the contact page' do
      visit '/contact'
      expect(page).to have_content('WHAT ARE YOU INTERESTED IN?')
    end

    scenario 'the FAQ page' do
      allow(Helpscout::Article).to receive(:all).and_return([ Helpscout::Article.new('name' => 'What is 2 + 2?', 'text' => '4') ])
      visit '/contact'
      click_link 'FAQ'
      expect(page).to have_content('FREQUENTLY ASKED QUESTIONS')
      click_button 'What is 2 + 2?'
      expect(page).to have_content('4')
    end

    scenario 'the assets page' do
      visit '/contact'
      click_link 'Assets'
      expect(page).to have_content('ASSETS')
    end

    scenario 'the press page' do
      create(:newsroom_item, title: 'Good news!', release_date: 1.day.ago, external_link: 'http://www.google.com/')
      visit '/contact'
      click_link 'Press'
      expect(page).to have_content('Good news!')
      click_link 'Good news!'
      expect(current_url).to include('https://www.google.com/')
    end
  end
end
