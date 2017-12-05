FactoryBot.define do

  factory :company do
    sequence(:name) { |n| "Company #{n}" }
  end

  factory :user do
    name 'Erlich Bachmann'
    password 'password'
    password_confirmation { password }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :registration do
    association :user
    age_range Registration::AGE_RANGES.first
    primary_role 'Founder'
  end

  factory :track do
    sequence(:name) { |n| "Track #{n}" }
    email_alias { "#{name.parameterize}@example.com" }
    color 'teal'
    icon 'eyeball'
  end

  factory :submission do
    sequence(:title) { |n| "Session #{n}" }
    description 'I am a session'
    contact_email 'test@example.com'
    association :track
    association :submitter, factory: :user
  end

  factory :venue do
    address '1060 W Addison St'
    city 'Chicago'
    state 'IL'
  end

  factory :attendee_message do
    association :submission
    subject 'Important'
    body 'I am a message!'
  end
end
