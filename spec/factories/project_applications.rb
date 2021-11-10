FactoryBot.define do
  factory :project_application do
    description { "Estou me candidatando para este projeto" }

    trait :declined do
      status { :declined }
      decline_reason { "Rejeitei seu pedido" }
    end
  end
end
