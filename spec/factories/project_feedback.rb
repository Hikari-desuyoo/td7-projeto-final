FactoryBot.define do
  factory :project_feedback do
    worker
    project
    score { 2 }
    comment { 'ah, muito bom!' }
  end
end
