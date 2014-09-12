require 'spec_helper'

describe Registration do

  it { should belong_to(:user) }
  it { should have_many(:session_registrations).dependent(:destroy) }
  it { should have_many(:submissions) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:contact_email) }

  it { should allow_mass_assignment_of(:contact_email) }

  it 'defaults its year to the current year' do
    expect(Registration.new.year).to eq(Date.today.year)
  end

  it 'defaults its calendar_token to a random value' do
    expect(Registration.new.calendar_token).not_to be_empty
  end

end
