require 'rails_helper'

describe 'hirer finishes project' do
  before(:each) do
    @worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    @hirer = create :hirer
    @project = create(:project, hirer: @hirer)

    @project_application = ProjectApplication.create!(
      project: @project,
      worker: @worker
    )

    @project_application.accepted!
  end

  it 'successfully' do
    @project.closed!

    login_as @hirer, scope: :hirer
    visit "/projects/#{@project.id}"

    find('#finish_button').click

    expect(page).to have_content(I18n.t('projects.show.finished_project'))

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
