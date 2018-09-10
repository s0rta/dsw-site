require 'rails_helper'

RSpec.describe Sponsorship, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:link_href) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:level) }
  it { is_expected.to validate_inclusion_of(:level).in_array(Sponsorship::LEVELS) }
  it { is_expected.to belong_to(:track) }
  it { is_expected.to allow_value('http://www.google.com/').for(:link_href) }
  it { is_expected.not_to allow_value('google.com/').for(:link_href) }

  it 'defaults its year to the current year' do
    expect(Sponsorship.new.year).to eq(Date.today.year)
  end

end
