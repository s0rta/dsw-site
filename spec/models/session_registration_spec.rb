require 'spec_helper'

describe SessionRegistration do
  it { should belong_to(:submission) }
  it { should belong_to(:registration) }
end
