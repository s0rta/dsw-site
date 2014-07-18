require 'spec_helper'

describe Track do

  it { should validate_presence_of(:name) }
  it { should have_many(:submissions).dependent(:destroy) }
  it { should have_and_belong_to_many(:chairs) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:icon) }
  it { should allow_mass_assignment_of(:email_alias) }

end
