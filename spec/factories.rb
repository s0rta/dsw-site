FactoryGirl.define do
  factory :user do
    name 'Erlich Bachmann'
    password 'password'
    password_confirmation { password }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :submission do
    association :submitter, factory: :user
  end
end
