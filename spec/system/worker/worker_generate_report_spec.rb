require 'rails_helper'

describe 'Worker requests(and receives) overview report' do
  it 'successfully' do
    # arrange
    worker = create(:worker)
    projects = create_list(:project, 3)
    closed_projects = create_list(:project, 3, :closed)

    accepted_application = create(
      :project_application,
        :finished_project,
        status: :accepted
    )
    five_star_project = accepted_application.project

    create(
      :project_feedback,
        worker: worker,
        project: five_star_project,
        score: 5
        )

    projects << five_star_project
  end
end
