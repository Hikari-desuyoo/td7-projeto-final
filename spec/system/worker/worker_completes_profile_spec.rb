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
        expect(page).to_not have_css('.homepage_projects')
        expect(page).to_not have_css('.no_projects_notice')
        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'successfully fills in profile details' do 
        visit root_path

        fill_in 'worker_name', with: 'nome'
        fill_in 'worker_surname', with: 'sobrenome'
        fill_in 'worker_social_name', with: 'nome social'
        fill_in 'worker_birth_date', with: '12/2/2002'
        fill_in 'worker_education', with: 'Formação'
        fill_in 'worker_description', with: 'descrição'
        fill_in 'worker_experience', with: 'experiencia'
        find('#worker_occupation_id option:first-of-type').select_option
        within '.edit_worker' do
            click_on 'commit'
        end

        expect(page).to_not have_css('#complete_profile_form')
        expect(page).to_not have_css('.profile_still_incomplete')
        expect(page).to have_css('.no_projects_notice')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end

    it 'fills in nothing' do
        visit root_path
        within '.edit_worker' do
            click_on 'commit'
        end

        expect(page).to have_css('.edit_worker')
        expect(page).to have_content(I18n.t('alert.profile_still_incomplete'))
        expect(page).to_not have_css('.homepage_projects')
        expect(page).to_not have_css('.no_projects_notice')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end
end
