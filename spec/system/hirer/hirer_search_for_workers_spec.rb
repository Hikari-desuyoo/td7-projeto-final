require 'rails_helper'


describe 'Logged Hirer searchs for worker' do    
    include ActiveSupport::Testing::TimeHelpers
    before(:each) do
        dev = Occupation.create!(name: 'dev')
        @hirer = create :hirer


        @workers = [
            create(:worker, name: 'alguma coisa nada a ver', occupation:dev),
            create(:worker, occupation:dev),
            create(:worker, surname: 'alguma coisa', occupation:dev),
            create(:worker, occupation:dev),
            create(:worker, occupation:dev)
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
