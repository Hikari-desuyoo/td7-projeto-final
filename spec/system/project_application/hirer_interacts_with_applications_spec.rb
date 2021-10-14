require 'rails_helper'


describe 'Hirer visits homepage ' do 
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
            project: @project
        )


        @application2 = ProjectApplication.create!(
            worker: @worker,
            project: @project2
        )
    end

    it 'and sees his own projects applications' do
        login_as @hirer, scope: :hirer
        visit root_path
        expect(page).to have_css("#application-#{@application.id}")
        expect(page).to_not have_css("#application-#{@application2.id}")
        expect(page).to have_content("#{@worker.get_full_name} #{I18n.t('project_applications.hirer_view.is_applying')}")
        expect(page).to have_content(@project.title)
        expect(page).to have_css("#accept_button")
        expect(page).to have_css("#decline_button")
        expect(page).to have_content(I18n.t('project_applications.status.pending'))

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    context ' accepts application' do
        before :each do
            login_as @hirer, scope: :hirer
            visit root_path
            
            within "#application-#{@application.id}" do
                click_on 'accept_button'
            end
        end

        it 'and sees worker name' do

            expect(page).to have_content(I18n.t('project_applications.accept.success_notice'))
            expect(page).to have_css('.project_worker', text: @worker.get_full_name)

            expect(page).to_not have_css('.translation_missing')
            expect(page).to_not have_content('translation missing')
            
        end

        it 'and sees application as accepted' do
            visit root_path
            within "#application-#{@application.id}" do
                expect(page).to have_css('#accept_button')
                expect(page).to have_css('#decline_button')
                expect(page).to have_content(I18n.t('project_applications.status.accepted'))
            end

            expect(page.body).to_not include('translation-missing')
            expect(page.body).to_not include('translation missing')
        end
    end

    context ' declines application' do
        before :each do
            login_as @hirer, scope: :hirer
            visit root_path
            
            within "#application-#{@application.id}" do
                click_on 'decline_button'
            end
        end

        it 'and sees application as declined' do
            visit root_path
            within "#application-#{@application.id}" do
                expect(page).to have_css('#accept_button')
                expect(page).to have_css('#decline_button')
                expect(page).to have_content(I18n.t('project_applications.status.declined'))
            end

            expect(page.body).to_not include('translation-missing')
            expect(page.body).to_not include('translation missing')
        end
    end
end