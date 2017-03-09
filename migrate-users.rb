#!/usr/bin/env ruby

require 'pg'
require 'inversoft/passport_client'

if ARGV.length != 2
  puts 'Usage: migrate-users.rb <api-key> <passport-url>'
  exit 1
end


#
# Converts a DB timestamp to Epoch milliseconds
#
def convert_to_timestamp(db_value)
  (db_value.to_f * 1000).round
end

conn = PG::Connection.new('localhost', 5432, nil, nil, 'dsw_development', 'postgres', nil)
rs = conn.exec('SELECT * FROM users')

api_key = ARGV[0]
passport_url = ARGV[1]
client = Inversoft::PassportClient.new(api_key, passport_url)

users = []
rs.each do |row|
  encrypted_password = row['encrypted_password']
  factor = encrypted_password[4..6].to_i
  password = encrypted_password[29..60]
  salt = encrypted_password[7..28]
  users << {
      :active => true,
      :fullName => row['name'],
      :email => row['email'],
      :password => password,
      :verified => true,
      :encryptionScheme => 'bcrypt',
      :factor => factor,
      :salt => salt,
      :insertInstant => convert_to_timestamp(row['created_at']),
      :lastLoginInstant => convert_to_timestamp(row['last_sign_in_at'])
  }
end

response = client.import_users({:users => users})
if response.status != 200
  puts "Failed while importing users. Error was #{response.error_response}"
  exit 1
end
