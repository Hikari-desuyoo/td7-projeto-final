FactoryBot.define do
  factory :hirer do
    sequence(:email) { |n| "test#{n}@email.com" }
    password { '123456789' }
    username { FFaker::NameBR.unique.name }
  end
end
