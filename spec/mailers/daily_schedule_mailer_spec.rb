require 'rails_helper'

RSpec.describe DailyScheduleMailer, type: :mailer do

  let(:registration) { FactoryGirl.build(:registration) }

  describe 'the Monday e-mail' do
    let(:mail) { described_class.notify_of_monday_daily_schedule(registration) }

    it 'renders properly' do
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(registration.user.email)
      expect(mail).to have_subject('Your Denver Startup Week Daily Schedule for Monday 9/25')
    end
  end

  describe 'the Tuesday e-mail' do
    let(:mail) { described_class.notify_of_tuesday_daily_schedule(registration) }

    it 'renders properly' do
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(registration.user.email)
      expect(mail).to have_subject('Your Denver Startup Week Daily Schedule for Tuesday 9/26')
    end
  end

  describe 'the Wednesday e-mail' do
    let(:mail) { described_class.notify_of_wednesday_daily_schedule(registration) }

    it 'renders properly' do
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(registration.user.email)
      expect(mail).to have_subject('Your Denver Startup Week Daily Schedule for Wednesday 9/27')
    end
  end

  describe 'the Thursday e-mail' do
    let(:mail) { described_class.notify_of_thursday_daily_schedule(registration) }

    it 'renders properly' do
      pending
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(registration.user.email)
      expect(mail).to have_subject('Your Denver Startup Week Daily Schedule for Thursday 9/28')
    end
  end

  describe 'the Friday e-mail' do
    let(:mail) { described_class.notify_of_friday_daily_schedule(registration) }

    it 'renders properly' do
      pending
      expect(mail).to deliver_from('Denver Startup Week <info@denverstartupweek.org>')
      expect(mail).to deliver_to(registration.user.email)
      expect(mail).to have_subject('Your Denver Startup Week Daily Schedule for Friday 9/29')
    end
  end
end
