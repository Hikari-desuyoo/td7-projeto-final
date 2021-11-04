require 'rails_helper'


describe 'Logged (complete)Worker sees own profile' do    
    include ActiveSupport::Testing::TimeHelpers

    before(:each) do
        Occupation.create!(name: 'dev')

        @worker = create(:worker, :complete)
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit root_path

        click_on 'worker_profile_button'

        expect(page).to have_css('#worker_details')
        expect(page).to have_content(@worker.get_full_name)
        expect(page).to have_css('#average_score', text:'-')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
