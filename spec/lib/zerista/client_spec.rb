require 'spec_helper'

describe Zerista::Client do

  it 'generates a signature based on request params and API keys' do
    client = Zerista::Client.new('denverstartupweek', '3', '5vucuk6NMjrDhkP6WBVHCA==')
    get_params = { 'format' => 'atom' }
    post_params = { 'user[first_name]' => 'Sandrine',
                    'user[last_name]' => 'Wellton',
                    'user[account_attributes][account_name]' => 'sandrine',
                    'user[mapbuzz_auth_attributes][password]' => 'mypassword',
                    'user[mapbuzz_auth_attributes][email]' => 'sandrine@mapbuzz.com',
                    'user[mapbuzz_auth_attributes][email_confirmation]' => 'sandrine@mapbuzz.com' }
    expect(client.signature_for_params(get_params, post_params)).to eq('7c3dcce0a03120c0ec1b61fca95f0cf3')
  end
end
