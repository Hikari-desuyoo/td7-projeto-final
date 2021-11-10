FactoryBot.define do
  factory :worker do
    sequence(:email) { |n| "test#{n}@email.com" }
    password { '123456789' }

    trait :complete do
      sequence(:name) { FFaker::NameBR.unique.first_name }
      sequence(:surname) { FFaker::NameBR.unique.last_name }
      occupation { Occupation.first }
      birth_date { '2002-06-27' }
    end
  end
end
