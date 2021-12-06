require 'rails_helper'

describe 'worker tries to give hirer feedback' do
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

    HirerFeedback.create!(
      worker: worker,
      hirer: hirer,
      score: 4
    )

    login_as worker, scope: :worker
    post "/hirers/#{hirer.id}/feedbacks",
    params: { hirer_feedback: { score: 3, comment: 'muito bom' } }

    expect(hirer.hirer_feedbacks.where(worker: worker).length).to eq(1)
  end

  it 'without having participated and fails' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)
    create(:project, hirer: hirer)

    login_as worker, scope: :worker

    post "/hirers/#{hirer.id}/feedbacks",
    params: { hirer_feedback: { score: 3, comment: 'muito bom' } }

    expect(hirer.hirer_feedbacks.where(worker: @worker).length).to eq(0)
  end
end
