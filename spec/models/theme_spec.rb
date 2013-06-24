require 'spec_helper'

describe Theme do
  it { should validate_presence_of(:name) }
  it { should have_many(:submissions) }
end
