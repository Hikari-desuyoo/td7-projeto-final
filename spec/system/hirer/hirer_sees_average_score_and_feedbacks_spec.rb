require 'rails_helper'


describe 'Logged (complete)Hirer' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        @worker = create(:worker, :complete, occupation: Occupation.create!(name: 'dev'))
        @hirer = create :hirer

        HirerFeedback.new(
            worker: @worker,
            hirer: @hirer,
            score: 2
        ).save(validate: false)


        HirerFeedback.new(
            worker: @worker,
            hirer: @hirer,
            score: 4,
            comment: 'bom projetador de projetos'
        ).save(validate: false)

        HirerFeedback.new(
            worker: @worker,
            hirer: @hirer,
            score: 5
        ).save(validate: false)
    end

    it 'successfully sees own score' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on 'hirer_profile_button'

        expect(page).to have_css('#average_score', text:'3,67')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'successfully sees feedbacks' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on 'hirer_profile_button'

        within '#hirer_feedbacks' do
            expect(page).to have_content(@worker.get_full_name, count:3)#NÃO ACONTECE NORMALMENTE(3 vezes mesma pessoa)
            expect(page).to have_content('bom projetador de projetos')
            expect(page).to have_content('5')
            expect(page).to have_content('4')
            expect(page).to have_content('2')
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
