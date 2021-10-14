require 'rails_helper'


describe 'Logged (complete)Worker sees own score' do    
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

        WorkerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 2
        )


        WorkerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 4
        )

        WorkerFeedback.create!(
            worker: @worker,
            hirer: @hirer,
            score: 5
        )
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit root_path

        click_on 'worker_profile_button'

        expect(page).to have_css('#worker_details')
        expect(page).to have_content(@worker.get_full_name)
        
        expect(page).to have_css('#average_score', text:/^3,67$/)

        expect(page).to_not have_css('.translation_missing')
        expect(page).to_not have_content('translation_missing')
    end
end
