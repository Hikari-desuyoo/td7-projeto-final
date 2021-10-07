require 'rails_helper'

describe 'Visitor login' do    
    def create_worker
        Worker.create!(
            email: 'test@mail.com',
            password: '123456789'
        )
    end

    def visit_login_page
        visit root_path
        find('#worker_login_link').click
    end

    it 'successfully' do
        create_worker

        visit_login_page
        fill_in 'worker_email', with: 'test@mail.com'
        fill_in 'worker_password', with: '123456789'
        click_on 'commit'

        expect(current_path).to eq root_path
        expect(page).to_not have_css('.signup')
        expect(page).to_not have_css('.login')
        expect(page).to have_css('#welcome_worker')
        expect(page).to have_css('#logout_link')
        expect(page).to_not have_css('.translation_missing')
    end
end