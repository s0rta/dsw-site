OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
  provider: 'linkedin',
  uid:      '123545',
  info: {
    name: 'Test User',
    email: 'test@example.com',
    description: 'I am a test user'
  }
})
