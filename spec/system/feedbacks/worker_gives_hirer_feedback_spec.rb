require 'rails_helper'

describe 'worker tries to give hirer feedback' do
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

    it 'successfully if hirer hired at least once' do
        @project.finished!

        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        #PROJECT PAGE
        within ".project_hirer" do
            find(".feedback_button").click
        end

        #HIRER FEEDBACK # NEW
        fill_in 'hirer_feedback_score', with: '1'
        fill_in 'hirer_feedback_comment', with: 'muito bom!'
        within '#hirer_feedback_form' do
            click_on 'commit'
        end
        
        #HIRER PROFILE
        expect(page).to have_content(I18n.t('feedbacks.create.submit_success'))

        within '#your_feedback' do
            expect(page).to have_content('muito bom!')
            expect(page).to have_css('.score', text: '1')
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'but sees no feedback button if project is still open' do
        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        within ".project_hirer" do
            expect(page).to_not have_css(".feedback_button")
        end

    end

    it 'but sees no feedback button if project is not finished' do
        @project.closed!

        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        within ".project_hirer" do
            expect(page).to_not have_css(".feedback_button")
        end

    end

    it 'and sees no feedback button for workers' do
        @project.finished!

        login_as @worker, scope: :worker
        visit "/projects/#{@project.id}"

        expect(page).to_not have_css(".project_worker .feedback_button")
    end

end