require 'rails_helper'


describe 'Logged (complete)Hirer' do    
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

        @hirer = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789',  
            username: 'mister hirer'
        )

        HirerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 2
        )


        HirerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 4,
            comment: 'bom projetador de projetos'
        )

        HirerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 5
        )
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
