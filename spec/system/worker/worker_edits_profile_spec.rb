require 'rails_helper'


describe 'Logged (complete)Worker edits profile' do    
    before(:each) do
        Occupation.create!(name: 'dev')

        @worker = create(:worker, :complete)
    
        login_as @worker, scope: :worker
        visit root_path
        
        click_on 'worker_profile_button'
        click_on 'edit_profile_button'
    end

    it 'successfully' do 
        fill_in 'worker_education', with: 'Formação2'
        fill_in 'worker_description', with: 'descrição2'
        fill_in 'worker_experience', with: 'experiencia2'
        find('#worker_occupation_id option:first-of-type').select_option
        
        within '.edit_worker' do
            click_on 'commit'
        end

        expect(@worker.education).to_not eq('Formação2')
        expect(@worker.description).to_not eq('descrição2')
        expect(@worker.experience).to_not eq('experiencia2')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
