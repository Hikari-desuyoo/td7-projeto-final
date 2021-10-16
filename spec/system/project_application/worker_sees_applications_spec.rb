require 'rails_helper'


describe 'Worker visits my applications page' do 
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

        @hirer2 = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789',
            username: 'mister hirer2'
        )

        @project = Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            )

        @project2 = Project.create!(
            title: 'titulo2',
            description: 'descrição2',
            skills_needed: 'habilidades2',
            max_pay_per_hour: '123',
            open_until: 5.days.from_now,
            hirer: @hirer2
        )

        @application = ProjectApplication.create!(
            worker: @worker,
            project: @project,
            description: 'descricaoproposta'
        )


        @application2 = ProjectApplication.create!(
            worker: @worker,
            project: @project2,
            description: 'descricaoproposta2'
        )

        @application2.declined!

        login_as @worker, scope: :worker

        visit root_path
        click_on 'my_project_applications_button'
    end

    it 'and sees his own projects applications' do
        expect(page).to have_content(@application.project.title)
        expect(page).to have_content(I18n.t('project_applications.status.pending'))
        expect(page).to have_css(".see_more_button")
        
        expect(page).to have_content(@application2.project.title)
        expect(page).to have_content(I18n.t('project_applications.status.declined'))

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end