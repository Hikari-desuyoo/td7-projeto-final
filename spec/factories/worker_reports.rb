FactoryBot.define do
  factory :worker_report do
    project_count { 1 }
    best_scored_project { nil }
    worst_scored_project { nil }
  end
end
