# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "#{n}@test.local" }
    password '12345678'
    password_confirmation '12345678'
    sequence(:phone_number) { |n| "#{n}#{n}#{n}-#{n}#{n}#{n}-#{n}#{n}#{n}#{n}"}
    date_of_birth DateTime.now - 40.years
  end
end
