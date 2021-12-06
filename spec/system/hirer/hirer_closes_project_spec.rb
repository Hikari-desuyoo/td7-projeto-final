require 'rails_helper'

describe 'hirer closes project' do
  it 'successfully' do
    worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    login_as hirer, scope: :hirer
    visit "/projects/#{project.id}"

    find('#close_button').click

    expect(page).to have_content(I18n.t('projects.show.closed_project'))

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
