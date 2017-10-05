require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do

  let(:session) { FactoryGirl.build(:submission) }

  describe 'the thanks e-mail' do
    let(:mail) { described_class.session_thanks(session) }

    it 'renders properly' do
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(session.submitter.email, session.contact_email)
      expect(mail).to have_subject('Thank you, DSW session organizers!')
    end
  end
end
