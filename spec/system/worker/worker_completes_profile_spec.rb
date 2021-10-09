require 'rails_helper'


describe 'Logged (incomplete)Worker ' do    
    before(:each) do
        Occupation.create!(name: 'dev')

        @worker = Worker.create!(
            email: 'test@mail.com',
            password: '123456789'
        )
    
        login_as @worker, scope: :worker
    end

    it 'sees form to complete profile' do 
        visit root_path

        expect(page).to have_css('.edit_worker')
    end

    it 'successfully fills in profile details' do 
        visit root_path

        fill_in 'worker_full_name', with: 'nome completo'
        fill_in 'worker_social_name', with: 'nome social'
        fill_in 'worker_birth_date', with: '12/2/2002'
        fill_in 'worker_education', with: 'Formação'
        fill_in 'worker_description', with: 'descrição'
        fill_in 'worker_experience', with: 'experiencia'
        select 'Desenvolvedor', from: 'worker_occupation_id'
        click_on 'commit'

        expect(page).to_not have_css('#complete_profile_form')
    end

    it 'fills in nothing' do
        visit root_path
        click_on 'commit'

        expect(page).to have_css('.edit_worker')
    end
end
