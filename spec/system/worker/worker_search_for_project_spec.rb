require 'rails_helper'


describe 'Logged (complete)Worker searchs for project' do    
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
            password: '123456789',
            username: 'mister hirer'
        )

        @hirer2 = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789',
            username: 'mister hirer2'
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
                title: 'títULO2',
                description: 'me ache',
                skills_needed: 'habilidades2',
                max_pay_per_hour: '123',
                open_until: 3.days.from_now,
                hirer: @hirer1
            ),
            Project.create!(
                title: 'outra_coisa',
                description: 'descrição3',
                skills_needed: 'mÊ AcHe',
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
                hirer: @hirer2
            )
        ]
    
        
    end

    def search_for(term)
        within('#search_bar') do
            fill_in 'search_term', with: term
            click_on 'commit'
        end
    end

    it 'by title successfully' do
        travel 3.day do   
            login_as @worker, scope: :worker
            visit root_path
            search_for('titulo')     
            match_projects = [@projects[0], @projects[1]]
            non_match_projects = @projects - match_projects

            match_projects.each do |project|
                expect(page).to have_css(".project_#{project.id}")
            end

            non_match_projects.each do |project|
                expect(page).to_not have_css(".project_#{project.id}")
            end
        end

        expect(page).to_not have_css('.translation_missing')
    end

    it 'by other text informations successfully' do
        login_as @worker, scope: :worker
        visit root_path
        
        search_for('me ache')


        [@projects[1], @projects[2]].each do |project|
            expect(page).to have_css(".project_#{project.id}")
        end

        expect(page).to_not have_css('.translation_missing')
    end

    it 'and finds nothing' do
        login_as @worker, scope: :worker
        visit root_path
        
        search_for('batatinha')


        expect(page).to have_css("#no_results_notice")
        expect(page).to have_content(I18n.t("search.search.no_results_notice"))
        

        expect(page).to_not have_css('.translation_missing')
    end




end
