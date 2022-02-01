FactoryBot.define do
  factory :project_application do
    worker
    project
    sequence(:description) { |n| "Estou me candidatando para este projeto #{n}" }
    trait :declined do
      status { :declined }
      decline_reason { 'Rejeitei seu pedido' }
    end

    trait :finished_project do
      project do
        association :project,
        status: :finished
      end
    end
  end
end
