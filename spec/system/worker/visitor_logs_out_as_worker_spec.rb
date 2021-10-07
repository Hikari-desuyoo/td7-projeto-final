require 'rails_helper'

describe 'Visitor logs out' do    
    def create_worker
        Worker.create!(
            email: 'test@mail.com',
            password: '123456789'
        )
    end

    it 'successfully' do
        worker = create_worker
        
        login_as worker, scope: :worker

        visit root_path

        find('#logout_link').click

        expect(current_path).to eq root_path
        expect(page).to have_css('.signup')
        expect(page).to have_css('.login')
        expect(page).to_not have_css('#logout_link')
        expect(page).to_not have_css('#welcome_worker')
    end
end