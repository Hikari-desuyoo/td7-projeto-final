FactoryBot.define do
    factory :project do
        sequence(:title) { |n| "titulo#{n}" }
        sequence(:description) { |n| "descrição#{n}" }
        sequence(:skills_needed) { |n| "habilidades#{n}" }
        max_pay_per_hour { '123' }
        open_until { 5.days.from_now }

        trait :three_days do
            open_until { 3.days.from_now }
        end

        trait :five_days do
            #redudant but necessary for legibility
            open_until { 5.days.from_now }
        end

        trait :seven_days do
            open_until { 7.days.from_now }
        end
    end
end