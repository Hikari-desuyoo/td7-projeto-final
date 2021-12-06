require 'rails_helper'

describe 'Worker visits my applications page' do
  it 'and sees his own projects applications' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)
    hirer2 = create(:hirer)

    project = create(:project, hirer: hirer)
    project2 = create(:project, hirer: hirer2)

    application = create(
      :project_application,
      worker: worker,
      project: project
    )

    application2 = create(
      :project_application,
      worker: worker,
      project: project2
    )

    application2.declined!

    login_as worker, scope: :worker

    visit root_path
    click_on 'my_project_applications_button'

    expect(page).to have_content(application.project.title)
    expect(page).to have_content(I18n.t('project_applications.status.pending'))
    expect(page).to have_css('.see_more_button')

    expect(page).to have_content(application2.project.title)
    expect(page).to have_content(I18n.t('project_applications.status.declined'))

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
