require 'rails_helper'

describe 'Visitor signs up' do    
    def visit_sign_up_page
        visit root_path
        find('#hirer_signup_link').click
    end

    it 'successfully' do
        visit_sign_up_page
        fill_in 'hirer_email', with: 'test@mail.com'
        fill_in 'hirer_username', with: 'mister hirer'
        fill_in 'hirer_password', with: '123456789'
        fill_in 'hirer_password_confirmation', with: '123456789'
        click_on 'commit'


        expect(current_path).to eq root_path
        expect(page).to_not have_css('.signup')
        expect(page).to_not have_css('.login')
        expect(page).to have_css('#welcome_hirer')
        expect(page).to have_css('#logout_link')
        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end