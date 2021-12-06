require 'rails_helper'

describe 'worker tries to give hirer feedback' do
  it 'successfully if hirer hired at least once' do
    worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    project.finished!

    login_as worker, scope: :worker
    visit "/projects/#{project.id}"

    # PROJECT PAGE
    within '.project_hirer' do
      find('.feedback_button').click
    end

    # HIRER FEEDBACK # NEW
    fill_in 'hirer_feedback_score', with: '1'
    fill_in 'hirer_feedback_comment', with: 'muito bom!'
    within '#hirer_feedback_form' do
      click_on 'commit'
    end

    # HIRER PROFILE
    expect(page).to have_content(I18n.t('feedbacks.create.submit_success'))

    within '#your_feedback' do
      expect(page).to have_content('muito bom!')
      expect(page).to have_css('.score', text: '1')
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'but sees no feedback button if project is still open' do
    worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!

    login_as worker, scope: :worker
    visit "/projects/#{project.id}"

    within '.project_hirer' do
      expect(page).to_not have_css('.feedback_button')
    end
  end

  it 'but sees no feedback button if project is not finished' do
    worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    project.closed!

    login_as worker, scope: :worker
    visit "/projects/#{project.id}"

    within '.project_hirer' do
      expect(page).to_not have_css('.feedback_button')
    end
  end

  it 'and sees no feedback button for workers' do
    worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    hirer = create(:hirer)
    project = create(:project, hirer: hirer)

    project_application = ProjectApplication.create!(
      project: project,
      worker: worker
    )

    project_application.accepted!
    project.finished!

    login_as worker, scope: :worker
    visit "/projects/#{project.id}"

    expect(page).to_not have_css('.project_worker .feedback_button')
  end
end
