require 'rails_helper'

describe 'Visitor login' do    
    def create_hirer
        Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )
    end

    def visit_login_page
        visit root_path
        find('#hirer_login_link').click
    end

    it 'successfully' do
        create_hirer

        visit_login_page
        fill_in 'hirer_email', with: 'test@mail.com'
        fill_in 'hirer_password', with: '123456789'
        click_on 'commit'

        expect(current_path).to eq root_path
        expect(page).to_not have_css('.signup')
        expect(page).to_not have_css('.login')
        expect(page).to have_css('#welcome_hirer')
        expect(page).to have_css('#logout_link')
        expect(page).to_not have_css('.translation_missing')
        expect(page).to_not have_css('.no_projects_notice')
        expect(page).to_not have_css('.homepage_projects')
    end
end