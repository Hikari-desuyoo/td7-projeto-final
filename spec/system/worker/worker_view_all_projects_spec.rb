require 'rails_helper'


describe 'Logged (complete)Worker' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        Occupation.create!(name: 'dev')

        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27'
        )

        @hirer1 = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789'
        )

        @hirer2 = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789'
        )

        @projects = [
            Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer1
            ),
            Project.create!(
                title: 'titulo2',
                description: 'descrição2',
                skills_needed: 'habilidades2',
                max_pay_per_hour: '123',
                open_until: 2.days.from_now,
                hirer: @hirer1
            ),
            Project.create!(
                title: 'titulo3',
                description: 'descrição3',
                skills_needed: 'habilidades3',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer2
            )
        ]
    
        
    end

    it 'sees all projects on homepage' do
        login_as @worker, scope: :worker
        visit root_path

        @projects.each do |project|
            expect(page).to have_css(".project_#{project.id}")
        end

        expect(page).to_not have_css('.translation_missing')
    end

    it 'sees all open projects on homepage' do
        login_as @worker, scope: :worker
    
        travel 4.day do
            visit root_path
            [@projects[0], @projects[2]].each do |project|
                expect(page).to have_css(".project_#{project.id}")
            end
            expect(page).to_not have_css(".project_#{@projects[1].id}")
        end

        expect(page).to_not have_css('.translation_missing')

    end
end
