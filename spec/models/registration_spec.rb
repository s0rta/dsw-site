require 'spec_helper'

RSpec.describe Registration, type: :model do
  before do
    allow(ListSubscriptionJob).to receive(:perform)
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:session_registrations).dependent(:destroy) }
  it { is_expected.to have_many(:submissions) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:contact_email) }

  it 'defaults its year to the current year' do
    expect(Registration.new.year).to eq(Date.today.year)
  end

  it 'defaults its calendar_token to a random value' do
    expect(Registration.new.calendar_token).not_to be_empty
  end

  context 'subscribing to mailing lists' do
    let(:user) do
      User.create! name: 'Test User',
                   email: 'test@example.com',
                   password: 'password',
                   password_confirmation: 'password'
    end

    it 'subscribes automatically on creation' do
      user.registrations.create! contact_email: 'test@example.com', year: 2015
      expect(ListSubscriptionJob).to have_received(:perform).with('test@example.com',
                                                                  registered_years: [ '2015' ])
    end

    it 'sends multiple registration years if applicable' do
      user.registrations.create! contact_email: 'test@example.com', year: 2015
      user.registrations.create! contact_email: 'test@example.com', year: 2016
      expect(ListSubscriptionJob).to have_received(:perform).with('test@example.com',
                                                                  registered_years: [ '2015',
                                                                                      '2016' ])
    end
  end
end
