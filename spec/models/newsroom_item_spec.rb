require 'rails_helper'

RSpec.describe NewsroomItem, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:release_date) }

  describe 'when no attachment is specified' do
    subject { NewsroomItem.new(attachment: nil) }

    it 'expects external_link to be present' do
      expect(subject.valid?).to be_falsy
      expect(subject.errors[:external_link]).to include("can't be blank")
    end
  end

  describe 'when no external_link is specified' do
    subject { NewsroomItem.new(external_link: nil) }

    it 'expects attachment to be present' do
      expect(subject.valid?).to be_falsy
      expect(subject.errors[:attachment]).to include("can't be blank")
    end
  end

end
