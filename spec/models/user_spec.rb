require 'spec_helper'

describe User do

  it { should have_many(:submissions) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:registrations).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:uid) }
  it { should allow_mass_assignment_of(:provider) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:description) }

  it { should allow_mass_assignment_of(:email).as(:admin) }
  it { should allow_mass_assignment_of(:password).as(:admin) }
  it { should allow_mass_assignment_of(:password_confirmation).as(:admin) }
  it { should allow_mass_assignment_of(:remember_me).as(:admin) }
  it { should allow_mass_assignment_of(:uid).as(:admin) }
  it { should allow_mass_assignment_of(:provider).as(:admin) }
  it { should allow_mass_assignment_of(:name).as(:admin) }
  it { should allow_mass_assignment_of(:description).as(:admin) }
  it { should allow_mass_assignment_of(:is_admin).as(:admin) }

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
