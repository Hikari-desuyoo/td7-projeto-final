require 'rails_helper'

describe 'worker tries to give project feedback' do
  it 'twice and fails' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)
    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    project.finished!

    ProjectFeedback.create!(
      worker: worker,
      project: project,
      score: 4
    )

    login_as worker, scope: :worker
    post "/projects/#{project.id}/feedbacks",
    params: { project_feedback: { score: 3, comment: 'muito bom' } }

    expect(project.project_feedbacks.where(worker: worker).length).to eq(1)
  end

  it 'without having participated and fails' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)
    login_as worker, scope: :worker
    post "/projects/#{project.id}/feedbacks",
    params: { project_feedback: { score: 3, comment: 'muito bom' } }

    expect(project.project_feedbacks.where(worker: worker).length).to eq(0)
  end
end
