FactoryBot.define do
  factory :project_application do
    sequence(:description) { |n| "Estou me candidatando para este projeto #{n}" }
    trait :declined do
      status { :declined }
      decline_reason { 'Rejeitei seu pedido' }
    end
  end
end
