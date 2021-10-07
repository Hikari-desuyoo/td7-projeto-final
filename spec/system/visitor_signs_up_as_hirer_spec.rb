require 'rails_helper'

describe 'Visitor signs up' do    
    def visit_sign_up_page
        visit root_path
        find('#signup_link').click
    end

    it 'successfully' do
        visit_sign_up_page
        fill_in 'hirer_email', with: 'test@mail.com'
        fill_in 'hirer_password', with: '123456789'
        fill_in 'hirer_password_confirmation', with: '123456789'
        click_on 'commit'

        expect(current_path).to eq root_path
    end
end