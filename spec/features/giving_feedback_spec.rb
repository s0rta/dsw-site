require 'spec_helper'

feature 'Providing feedback on submissions' do

  before do
    @track = Track.new name: 'Bizness'
    @track.save!
    FeatureToggler.activate_feedback!
  end

  scenario 'User tries to access feedback when feedback is closed' do
    pending
    FeatureToggler.deactivate_feedback!
    visit '/panel-picker'
    expect(page).to have_content('Feedback Is Closed')
    expect(current_path).to eq('/panel-picker/feedback_closed')
  end

end
