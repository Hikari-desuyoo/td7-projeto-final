require 'rails_helper'


describe 'Logged (complete)Worker sees own profile' do    
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
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit root_path

        click_on 'worker_profile_button'

        expect(page).to have_css('#worker_details')
        expect(page).to have_content(@worker.get_full_name)
        expect(page).to have_content('#edit_profile_button')
        expect(page).to have_css('#average_score', text:'-')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
