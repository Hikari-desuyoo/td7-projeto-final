require 'rails_helper'

describe 'Worker' do
  it 'cannot apply for a project twice' do
    Occupation.create!(name: 'dev')

    worker = create(:worker, :complete)
    project = create(:project)
    ProjectApplication.create!(
      project: project,
      worker: worker
    )

    login_as worker, scope: :worker
    post '/projects/1/project_applications'
    expect(response).to redirect_to(root_path)
  end
end
