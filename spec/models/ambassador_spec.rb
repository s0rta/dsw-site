require 'rails_helper'

RSpec.describe Ambassador, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:company) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:location) }
end
