require 'rails_helper'

RSpec.describe AttendeeMessage, type: :model do
  it { is_expected.to belong_to(:submission) }
  it { is_expected.to validate_length_of(:subject).is_at_most(100) }
  it { is_expected.to validate_presence_of(:body) }

  describe 'sent status', freeze_time: true do
    it 'is unsent when sent_at is nil' do
      expect(AttendeeMessage.new.sent_status).to eq('Unsent')
    end

    it 'is "Sent at <time>" when sent_at is present' do
      expect(AttendeeMessage.new(sent_at: DateTime.new(2017, 01, 02)).sent_status).to eq('Sent at January 02, 2017 00:00')
    end
  end
end
