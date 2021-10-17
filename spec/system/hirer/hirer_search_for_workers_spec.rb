require 'rails_helper'


describe 'Logged Hirer searchs for worker' do    
    include ActiveSupport::Testing::TimeHelpers
    before(:each) do
        Occupation.create!(name: 'dev')

        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )


        @workers = [
            Worker.create!(
                email: 'test2@mail.com',
                password: '123456789',
                name: 'alguma coisa nada a ver',
                surname: 'sobrenome2',
                birth_date: '2002-06-27'
            ),
            Worker.create!(
                email: 'test3@mail.com',
                password: '123456789',
                name: 'nome2',
                surname: 'sobrenome2',
                birth_date: '2002-06-27'
            ),
            Worker.create!(
                email: 'test4@mail.com',
                password: '123456789',
                name: 'nome2',
                surname: 'alguma coisa',
                birth_date: '2002-06-27'
            ),
            Worker.create!(
                email: 'test5@mail.com',
                password: '123456789',
                name: 'nome2',
                surname: 'sobrenome2',
                birth_date: '2002-06-27'
            )
        ]
    
        
    end

    def search_for(term)
        within('#search_bar') do
            fill_in 'search_term', with: term
            click_on 'commit'
        end
    end

    it 'successfully' do
        login_as @hirer, scope: :hirer
        visit root_path
        search_for('alguma coisa')     
        match_workers = [@workers[0], @workers[2]]
        non_match_workers = @workers - match_workers

        match_workers.each do |project|
            expect(page).to have_css(".worker_#{project.id}")
        end

        non_match_workers.each do |project|
            expect(page).to_not have_css(".worker_#{project.id}")
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'and finds nothing' do
        login_as @hirer, scope: :hirer
        visit root_path
        
        search_for('batatinha')


        expect(page).to have_css("#no_results")
        expect(page).to have_content(I18n.t("search.search.no_results"))
        

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
