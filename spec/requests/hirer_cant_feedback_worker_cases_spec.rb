require 'rails_helper'

describe 'hirer tries to give worker feedback' do
  it 'twice and fails' do
    worker = create(:worker)
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    project.finished!

    WorkerFeedback.create!(
      hirer: hirer,
      worker: worker,
      score: 4
    )
    login_as hirer, scope: :hirer
    post "/workers/#{worker.id}/feedbacks",
    params: { worker_feedback: { score: 3, comment: 'muito bom' } }

    expect(worker.worker_feedbacks.where(hirer: hirer).length).to eq(1)
  end

  it 'without having participated and fails' do
    worker = create(:worker)
    hirer = create(:hirer)
    create(:project, hirer: hirer)
    login_as hirer, scope: :hirer
    post "/workers/#{worker.id}/feedbacks",
    params: { worker_feedback: { score: 3, comment: 'muito bom' } }

    expect(worker.worker_feedbacks.where(hirer: hirer).length).to eq(0)
  end
end
