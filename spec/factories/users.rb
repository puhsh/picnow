# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "#{n}@test.local" }
    password '12345678'
    password_confirmation '12345678'
    sequence(:phone_number, (1..9).cycle) { |n| "214-555-#{n - 1}55#{n}#"}
    date_of_birth DateTime.now - 40.years
  end
end
