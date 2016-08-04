require 'rails_helper'

RSpec.describe Volunteership, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }

  it 'defaults its year to the current year' do
    expect(Volunteership.new.year).to eq(Date.today.year)
  end

end
