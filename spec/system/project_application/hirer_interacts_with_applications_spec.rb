require 'rails_helper'


describe 'Hirer visits homepage' do 
    before(:each) do
        @worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
        @hirer = create(:hirer)
        @hirer2 = create(:hirer)
        @project = create(:project, hirer: @hirer)
        @project2 = create(:project, hirer: @hirer2)

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
    end

    it 'and sees his own projects applications' do
        login_as @hirer, scope: :hirer
        visit root_path
        expect(page).to have_css(".project_application_details")

        expect(page).to_not have_css("#application-#{@application2.id}")
        expect(page).to have_content("#{@worker.get_full_name} #{I18n.t('project_applications.hirer_view.is_applying')}")
        expect(page).to have_content(@project.title)
        expect(page).to have_css(".see_more_button")

        expect(page).to have_content(I18n.t('project_applications.status.pending'))

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'sees application show page' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on(class: 'see_more_button')
        
        expect(page).to have_content(@project.title)
        expect(page).to have_content(@application.description)
        expect(page).to have_css("#accept_button")
        expect(page).to have_css("#decline_form")
        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    context 'accepts application' do
        before :each do
            login_as @hirer, scope: :hirer
            visit root_path

            click_on(class: 'see_more_button')
            
            click_on 'accept_button'
        end

        it 'and sees worker name' do
            click_on(@project.title)

            expect(page).to have_css('.project_worker', text: @worker.get_full_name)

            expect(page).to_not have_css('.translation_missing')
            expect(page).to_not have_content('translation missing')
        end

        it 'and sees application as accepted' do
            visit root_path
            within ".project_application_details" do
                expect(page).to have_content(I18n.t('project_applications.status.accepted'))
            end

            expect(page.body).to_not include('translation-missing')
            expect(page.body).to_not include('translation missing')
        end
    end

    context 'visits application' do
        before :each do
            login_as @hirer, scope: :hirer
            visit root_path
            
            click_on(class: 'see_more_button')
        end

        it 'and declines with no reason' do
            within '#decline_form' do
                click_on 'commit'
            end

            expect(page).to have_content(I18n.t('project_applications.status.declined'))
            expect(page).to have_content(I18n.t('project_applications.show.no_decline_reason'))

            expect(page.body).to_not include('translation-missing')
            expect(page.body).to_not include('translation missing')
        end

        it 'and declines with reason' do
            fill_in 'project_application_decline_reason', with: 'rejeitei porque sim'
            within '#decline_form' do
                click_on 'commit'
            end
            
            expect(page).to have_content(I18n.t('project_applications.status.declined'))
            expect(page).to have_content('rejeitei porque sim')
            

            expect(page.body).to_not include('translation-missing')
            expect(page.body).to_not include('translation missing')
        end

    end
end