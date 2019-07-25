require "rails_helper"

RSpec.describe VenueAdminship, type: :model do
  it { is_expected.to belong_to(:venue) }
  it { is_expected.to belong_to(:user) }
end
