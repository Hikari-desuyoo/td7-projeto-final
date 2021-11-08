FactoryBot.define do
  factory :worker do
    sequence(:email) { |n| "test#{n}@email.com" }
    password { '123456789' }

    trait :complete do
      sequence(:name) { |n| "nome#{n}" }
      sequence(:surname) { |n| "sobrenome#{n}" }
      birth_date { '2002-06-27' }
    end
  end
end
