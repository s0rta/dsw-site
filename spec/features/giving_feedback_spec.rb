require 'spec_helper'

feature 'Providing feedback on submissions' do

  before do
    @track = Track.new name: 'Bizness'
    @track.save!
  end

  let(:user) do
    create(:user, email: 'test@example.com', password: 'password')
  end

  let(:track) do
    Track.create! name: 'Founder', is_submittable: true
  end

  let!(:submission) do
    user.submissions.create! title: 'I am a session',
                             description: 'interesting stuff',
                             track: track,
                             contact_email: 'test@example.com',
                             state: 'open_for_voting'
  end

  describe 'when voting is open' do
    around(:each) do |example|
      travel_to EventSchedule::VOTING_OPEN_DATE + 1.day do
        example.run
      end
    end

    scenario 'User votes for a session when already signed in' do
      login_as user, scope: :user
      visit '/panel-picker'
      click_link 'View Topics'
      expect(page).to have_content('I am a session')

      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')

      # Clicking twice should have no effect
      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')
    end

    scenario 'User votes for a session after being prompted to sign in' do
      visit '/panel-picker'
      click_link 'View Topics'
      expect(page).to have_content('I am a session')

      click_link "Vote for 'I am a session'"
      fill_in 'E-mail Address', with: 'test@example.com'
      fill_in 'Password', with: 'password', match: :prefer_exact
      click_button 'Sign In'
      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')

      # Clicking twice should have no effect
      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')
    end

    scenario 'User votes for a session from the session detail page' do
      login_as user, scope: :user
      visit '/panel-picker'
      click_link 'View Topics'
      expect(page).to have_content('I am a session')
      click_link "interesting stuff"
      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')

      # Clicking twice should have no effect
      click_link "Vote for 'I am a session'"
      expect(page).to have_css('.vote-count', text: '1 vote')
    end
  end

  describe 'when voting areisclosed' do
    around(:each) do |example|
      travel_to EventSchedule::VOTING_CLOSE_DATE + 1.day do
        example.run
      end
    end

    scenario 'User tries to access feedback when feedback is closed' do
      visit '/panel-picker'
      expect(page).to have_content("Feedback for #{Date.today.year} is currently closed")
      expect(current_path).to eq('/panel-picker/feedback_closed')
    end
  end

end
