require 'spec_helper'

describe Submission do
  it { should belong_to(:track) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:format) }
  it { should validate_presence_of(:contact_email) }
  it { should ensure_inclusion_of(:format).in_array(Submission::FORMATS) }
  it { should ensure_inclusion_of(:day).in_array(Submission::DAYS) }
  it { should ensure_inclusion_of(:time_range).in_array(Submission::TIME_RANGES) }
end
