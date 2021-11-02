FactoryBot.define do
    factory :hirer do
      trait :common do
        email { 'test@mail.com' }
        password { '123456789' }
        username { 'mister hirer' }
      end
    end
  end