require 'rails_helper'

describe 'Visitor' do
  it 'cannot apply for a project' do
    Occupation.create!(name: 'dev')
    create(:worker, :complete)
    create(:project)

    post '/projects/1/project_applications'
    expect(response).to redirect_to(new_worker_session_path)
  end
end
