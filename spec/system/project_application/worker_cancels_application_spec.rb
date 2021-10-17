require 'rails_helper'


describe 'Logged (complete)Worker visits project page' do 
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
            title: 'titulo2',
            description: 'descrição2',
            skills_needed: 'habilidades2',
            max_pay_per_hour: '123',
            open_until: 5.days.from_now,
            hirer: @hirer
        )

        @application = ProjectApplication.create!(
            worker: @worker,
            project: @project,
            description: 'descricaoproposta'
        )
    end

    it 'then cancels application successfully and sees success notice' do
        login_as @worker, scope: :worker

        visit root_path
        click_on 'my_project_applications_button'
        click_on(class: 'see_more_button')

        click_on('cancel_button')

        expect(page).to have_content(I18n.t('project_applications.cancel.success_notice'))
        expect(page).to_not have_content(@project.title)

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')

    end


    it 'then tries to cancel application but fail because it was accepted' do
        @application.accepted!

        login_as @worker, scope: :worker

        visit root_path
        click_on 'my_project_applications_button'
        click_on(class: 'see_more_button')

        expect(page).to_not have_css('#cancel_button')

    end
end