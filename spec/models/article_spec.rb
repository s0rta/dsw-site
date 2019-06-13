require "rails_helper"

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(150) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to belong_to(:author) }
  it { is_expected.to have_and_belong_to_many(:tracks) }
end
