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

  factory :venue do
    address '1060 W Addison St'
    city 'Chicago'
    state 'IL'
  end
end
