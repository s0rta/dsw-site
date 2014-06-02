require 'spec_helper'

describe User do

  it { should have_many(:submissions) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:registrations).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:linkedin_uid) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:description) }

  it { should allow_mass_assignment_of(:email).as(:admin) }
  it { should allow_mass_assignment_of(:linkedin_uid).as(:admin) }
  it { should allow_mass_assignment_of(:name).as(:admin) }
  it { should allow_mass_assignment_of(:description).as(:admin) }
  it { should allow_mass_assignment_of(:is_admin).as(:admin) }

  describe 'creating from an auth hash' do
    let(:auth_hash) do
      {
        uid: 'abc123',
        info: {
          name: 'Test User',
          email: 'test@example.com',
          description: 'Some test guy'
        }
      }
    end

    it 'creates a new user when none exists' do
      user = User.find_or_create_from_auth_hash(auth_hash)
      expect(user).to eq(User.first)
      expect(user.linkedin_uid).to eq('abc123')
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('test@example.com')
      expect(user.description).to eq('Some test guy')
    end

    it 'finds and updates a preexisting user' do
      original = User.create! linkedin_uid: 'abc123', name: 'Test User', email: 'test@example.com'
      user = User.find_or_create_from_auth_hash(auth_hash)
      expect(user.id).to eq(original.id)
      expect(user.linkedin_uid).to eq('abc123')
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('test@example.com')
      expect(user.description).to eq('Some test guy')
    end

  end

end
