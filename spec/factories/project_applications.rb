FactoryBot.define do
  factory :project_application do
    worker
    project
    sequence(:description) { |n| "Estou me candidatando para este projeto #{n}" }
    trait :declined do
      status { :declined }
      decline_reason { 'Rejeitei seu pedido' }
    end

    trait :ten_star_project do
      project do
        association :project,
        status: :finished
      end
      
      status { :accepted }

      project_feedbacks do
        [
          association :project_feedbacks,
          project: project,
          score: 5
        ]
      end
    end
  end
end
