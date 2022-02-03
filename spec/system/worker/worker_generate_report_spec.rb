require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe 'Worker requests overview report' do
  context 'and sees it' do
    it 'successfully' do
      # ARRANGE
      worker = create(:worker, :complete)
      create_list(:project, 3, status: :open)
      create_list(:project, 3, status: :closed)

      create(
        :project_application,
        worker: worker,
        status: :pending
      )

      # five_star_project

      accepted_application = create(
        :project_application,
          :finished_project,
          worker: worker,
          status: :accepted
      )
      five_star_project = accepted_application.project

      create(
        :project_feedback,
          worker: worker,
          project: five_star_project,
          score: 5
          )

      # one_star_project

      accepted_application = create(
        :project_application,
          :finished_project,
          worker: worker,
          status: :accepted
      )

      one_star_project = accepted_application.project

      create(
        :project_feedback,
          worker: worker,
          project: one_star_project,
          score: 1
          )

      # no feedback project
      create(
        :project_application,
          :finished_project,
          worker: worker,
          status: :accepted
      )

      # ACT
      login_as worker, scope: :worker
      visit root_path

      click_on 'worker_profile_button'
      click_on 'see_report_button'
      click_on 'refresh_report_button'

      Sidekiq::Worker.drain_all

      visit current_path
      expect(page).to have_content("Análise de profissional: #{worker.get_full_name}")
      expect(page).to have_content("Feita em #{I18n.l(DateTime.now, format: :short)}")
      expect(page).to have_content('Até hoje, você entregou 4 projetos')

      within('#best_score_project') do
        expect(page).to have_content('O projeto com maior nota que você participou foi')
        expect(page).to have_link(five_star_project.title, href: project_path(five_star_project))
      end
      within('#worst_score_project') do
        expect(page).to have_content('O projeto com menor nota que você participou foi')
        expect(page).to have_link(one_star_project.title, href: project_path(one_star_project))
      end
    end

    it 'successfully even if no projects' do
      # ARRANGE
      worker = create(:worker, :complete)

      login_as worker, scope: :worker
      visit root_path

      click_on 'worker_profile_button'
      click_on 'see_report_button'
      click_on 'refresh_report_button'

      Sidekiq::Worker.drain_all

      visit current_path
      expect(page).to have_content('Análise de profissional')
      expect(page).to have_content("Feita em #{I18n.l(DateTime.now, format: :short)}")
      expect(page).to have_content('Até hoje, você entregou 0 projetos')
      expect(page).to_not have_css('#best_score_project')
      expect(page).to_not have_css('#worst_score_project')
    end
    context 'and sees processing page' do
      it 'successfully' do
        # ARRANGE
        worker = create(:worker, :complete)

        login_as worker, scope: :worker
        visit root_path

        click_on 'worker_profile_button'
        click_on 'see_report_button'
        click_on 'refresh_report_button'

        visit current_path
        expect(page).to have_content('Ainda estamos processando sua análise')
      end
    end
  end
end
