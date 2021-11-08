require 'rails_helper'

describe 'hirer tries to give worker feedback' do
  before(:each) do
    @worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
    @hirer = create(:hirer)
    @project = create(:project, hirer: @hirer)

    @project_application = ProjectApplication.create!(
      project: @project,
      worker: @worker
    )

    @project_application.accepted!
  end

  it 'successfully if worker was hired at least once' do
    @project.finished!

    login_as @hirer, scope: :hirer
    visit "/projects/#{@project.id}"

    # PROJECT PAGE
    within '.project_worker' do
      find('.feedback_button').click
    end

    # WORKER FEEDBACK # NEW
    fill_in 'worker_feedback_score', with: '1'
    fill_in 'worker_feedback_comment', with: 'muito bom!'
    within '#worker_feedback_form' do
      click_on 'commit'
    end

    # WORKER PROFILE
    expect(page).to have_content(I18n.t('feedbacks.create.submit_success'))

    within '#your_feedback' do
      expect(page).to have_content('muito bom!')
      expect(page).to have_css('.score', text: '1')
    end
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'but sees no feedback button if project is still open' do
    login_as @hirer, scope: :hirer
    visit "/projects/#{@project.id}"

    within '.project_worker' do
      expect(page).to_not have_css('.feedback_button')
    end
  end

  it 'but sees no feedback button if project is not finished' do
    @project.closed!

    login_as @hirer, scope: :hirer
    visit "/projects/#{@project.id}"

    within '.project_worker' do
      expect(page).to_not have_css('.feedback_button')
    end
  end

  it 'and sees no feedback button for themself' do
    @project.finished!

    login_as @hirer, scope: :hirer
    visit "/projects/#{@project.id}"

    expect(page).to_not have_css('.project_hirer .feedback_button')
  end
end
