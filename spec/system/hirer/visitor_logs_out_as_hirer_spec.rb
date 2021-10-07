require 'rails_helper'

describe 'Visitor logs out' do    
    def create_hirer
        Hirer.create!(
            email: 'test@mail.com',
            password: '123456789'
        )
    end

    it 'successfully' do
        hirer = create_hirer
        
        login_as hirer, scope: :hirer

        visit root_path

        find('#logout_link').click

        expect(current_path).to eq root_path
        expect(page).to have_css('#signup_link')
        expect(page).to have_css('#login_link')
        expect(page).to_not have_css('#logout_link')
    end
end