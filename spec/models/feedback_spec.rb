require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { is_expected.to belong_to(:submission) }
end
