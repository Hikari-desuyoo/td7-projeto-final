require 'rails_helper'


describe 'Logged hirer sees own profile' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        @hirer = create :hirer
    end

    it 'sees own profile' do
        login_as @hirer, scope: :hirer
        visit root_path

        click_on 'hirer_profile_button'

        expect(page).to have_css('#hirer_details')
        expect(page).to have_content(@hirer.username)
        expect(page).to have_css('#average_score', text:'-')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
