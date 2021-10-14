require 'rails_helper'

describe 'worker tries to give project feedback' do
    before(:each) do
        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27'
        )

        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )

        @project = Project.create!(
            title: 'titulo',
            description: 'descrição',
            skills_needed: 'habilidades',
            max_pay_per_hour: '123',
            open_until: 5.days.from_now,
            hirer: @hirer
        )

        @project_application = ProjectApplication.create!(
            project: @project,
            worker: @worker
        )

        @project_application.accepted!
    end

    it 'successfully if project finished ' do
        @project.finished!

        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        #PROJECT PAGE
        find(".project_feedback_button").click

        #PROJECT FEEDBACK # NEW
        fill_in 'project_feedback_score', with: '1'
        fill_in 'project_feedback_comment', with: 'muito bom!'
        within '#project_feedback_form' do
            click_on 'commit'
        end
        
        #PROJECT PAGE
        expect(page).to have_content(I18n.t('feedbacks.create.submit_success'))

        within '#your_feedback' do
            expect(page).to have_content('muito bom!')
            expect(page).to have_css('.score', text: '1')
        end

        expect(page).to_not have_css(".project_feedback_button")

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'but sees no feedback button if project is still open' do
        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        expect(page).to_not have_css(".project_feedback_button")

    end

    it 'but sees no feedback button if project is not finished' do
        @project.closed!

        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        expect(page).to_not have_css(".project_feedback_button")

    end

end