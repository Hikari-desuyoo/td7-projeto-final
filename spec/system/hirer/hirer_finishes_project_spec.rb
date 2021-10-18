require 'rails_helper'

describe 'hirer finishes project' do
    before(:each) do
        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27',
            occupation: Occupation.create!(name: 'dev')
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
            worker: @worker,
        )

        @project_application.accepted!
    end

    it 'successfully' do
        @project.closed!

        login_as @hirer, scope: :hirer
        visit "/projects/#{@project.id}"

        find("#finish_button").click
        
        expect(page).to have_content(I18n.t('projects.show.finished_project'))

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end