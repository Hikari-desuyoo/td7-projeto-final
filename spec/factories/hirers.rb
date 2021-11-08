FactoryBot.define do
  factory :hirer do
    sequence(:email) { |n| "test#{n}@email.com" }
    password { '123456789' }
    sequence(:username) { |n| "mister hirer ##{n}" }
  end
end
