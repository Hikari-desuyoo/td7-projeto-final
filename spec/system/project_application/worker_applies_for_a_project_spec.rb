require 'rails_helper'


describe 'Logged (complete)Worker visits project page' do 
    it 'and applies successfully' do
        Occupation.create!(name: 'dev')

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

        login_as @worker, scope: :worker
        visit root_path
        click_on @project.title
        
        fill_in 'description', with: 'quero trabalho'
        within '#project_application_form' do
            click_on 'commit'
        end

        
        expect(page).to have_content(I18n.t('project_applications.create.success'))
        expect(page).to have_css('#applied')
        expect(page).to have_content(I18n.t('projects.show.applied'))
        project_aplication = ProjectApplication.all[0]
        expect(project_aplication.worker).to eq(@worker)
        expect(project_aplication.project).to eq(@project)
        expect(project_aplication.description).to eq('quero trabalho')
        expect(page).to_not have_css('#project_application_form')  
        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
        
    end
end
