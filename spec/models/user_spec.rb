require 'spec_helper'

describe User do

  it { should have_many(:submissions) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:registrations).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

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
