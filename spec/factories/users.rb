FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    password 'password12345'
    password_confirmation 'password12345'
  end
end
