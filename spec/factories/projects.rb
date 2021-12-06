FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "Projeto para freelancers nº #{n}" }
    description { FFaker::Lorem.paragraph }
    skills_needed { FFaker::Skill.tech_skills.join(', ') }
    max_pay_per_hour { rand(100..1000).to_s }
    open_until { 5.days.from_now }

    trait :three_days do
      open_until { 3.days.from_now }
    end

    trait :five_days do
      # redudant but necessary for legibility
      open_until { 5.days.from_now }
    end

    trait :seven_days do
      open_until { 7.days.from_now }
    end
  end
end
