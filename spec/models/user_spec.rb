require 'spec_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:submissions) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }
  it { is_expected.to have_many(:registrations).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  describe 'creating from an auth hash' do
    let(:auth_hash) do
      {
        provider: 'linkedin',
        uid: 'abc123',
        info: {
          name: 'Test User',
          email: 'test@example.com',
          description: 'Some test guy'
        }
      }
    end

    it 'creates a new user when none exists' do
      user = User.from_omniauth(auth_hash)
      expect(user).to eq(User.first)
      expect(user.provider).to eq('linkedin')
      expect(user.uid).to eq('abc123')
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('test@example.com')
    end

    it 'finds and updates a preexisting user' do
      original = User.create! uid: 'abc123', provider: 'linkedin', name: 'Test User', email: 'test@example.com', password: 'password'
      user = User.from_omniauth(auth_hash)
      expect(user.id).to eq(original.id)
      expect(user.uid).to eq('abc123')
      expect(user.provider).to eq('linkedin')
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('test@example.com')
    end
  end
end
