require 'rails_helper'


describe 'Logged hirer sees own profile' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        @hirer = Hirer.create!(
            email: 'test2@mail.com',
            password: '123456789',
            username: 'nome2'
        )
    end

    it 'sees own profile' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on 'hirer_profile_button'

        expect(page).to have_css('#hirer_details')
        expect(page).to have_content(@hirer.username)
        expect(page).to have_css('#average_score', text:'-')

        expect(page).to_not have_css('.translation_missing')
        expect(page).to_not have_content('translation_missing')
    end
end
