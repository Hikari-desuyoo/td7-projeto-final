require 'rails_helper'

describe 'project feedback shows up on project page' do
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

        @project_feedback = ProjectFeedback.create!(
            project: @project,
            worker: @worker,
            score: 5,
            comment: 'Projeto muito bom'
        )

        @project.finished!
    end

    it 'successfully' do
        @project.finished!
        
        visit "/projects/#{@project.id}"

        within '.project_feedback' do
            expect(page).to have_content(@project_feedback.worker.get_full_name)
            expect(page).to have_content(@project_feedback.comment)
            expect(page).to have_content('5')
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end


end