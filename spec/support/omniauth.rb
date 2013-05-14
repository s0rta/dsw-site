OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
  provider: 'linkedin',
  uid:      '123545',
  info: {
    name: 'Test User',
    email: 'test@example.com',
    description: 'I am a test user'
  }
})
