require 'rails_helper'

describe 'Visitor logs out' do    
    def create_hirer
        Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )
    end

    it 'successfully' do
        hirer = create_hirer
        
        login_as hirer, scope: :hirer

        visit root_path

        find('#logout_link').click

        expect(current_path).to eq root_path
        expect(page).to have_css('.signup')
        expect(page).to have_css('.login')
        expect(page).to_not have_css('#logout_link')
        expect(page).to_not have_css('#welcome_hirer')
    end
end