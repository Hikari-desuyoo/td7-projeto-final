require 'rails_helper'


describe 'Logged (complete)Hirer' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        Occupation.create!(name: 'dev')

        @hirer2 = Hirer.create!(
            email: 'test23@mail.com',
            password: '123456789',  
            username: 'mister hirer2'
        )

        @hirer = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789',  
            username: 'mister hirer'
        )


        @projects = [
            Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            ),
            Project.create!(
                title: 'titULO2',
                description: 'descrição2',
                skills_needed: 'habilidades2',
                max_pay_per_hour: '123',
                open_until: 3.days.from_now,
                hirer: @hirer
            ),
            Project.create!(
                title: 'outra_coisa',
                description: 'descrição3',
                skills_needed: 'habilidades23',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer2
            ),
            Project.create!(
                title: 'titulo',
                description: 'titulo',
                skills_needed: 'titulo',
                max_pay_per_hour: '123',
                open_until: 1.days.from_now,
                hirer: @hirer
            )
        ]

    end

    it 'successfully sees my projects page' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on 'my_projects_button'

        not_hirer_projects = [@projects[2]]
        hirer_projects = @projects - not_hirer_projects

        hirer_projects.each do |project|
            expect(page).to have_content(project.title)
        end

        not_hirer_projects.each do |project|
            expect(page).to_not have_content(project.title)
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end


end
