require 'spec_helper'

describe Submission do

  it { should belong_to(:track) }
  it { should have_many(:votes).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:contact_email) }
  # it { should ensure_inclusion_of(:format).in_array(Submission::FORMATS) }
  # it { should ensure_inclusion_of(:start_day).in_array(Submission::DAYS) }
  # it { should ensure_inclusion_of(:end_day).in_array(Submission::DAYS) }
  # it { should ensure_inclusion_of(:time_range).in_array(Submission::TIME_RANGES) }
  it { should ensure_length_of(:location).is_at_most(255) }

  it 'defaults its year to the current year' do
    expect(Submission.new.year).to eq(Date.today.year)
  end

end
