require 'rails_helper'


describe 'Logged Hirer creates project' do    
    before(:each) do
        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789'
        )
    
        login_as @hirer, scope: :hirer
    end

    it 'successfully' do 
        visit root_path
        find('#new_project_link').click
        fill_in 'project_title', with: 'titulo'
        fill_in 'project_description', with: 'descrição'
        fill_in 'project_skills_needed', with: 'habilidades'
        fill_in 'project_max_pay_per_hour', with: '234.42'
        fill_in 'project_open_until', with: '10/11/2022'
        check 'project_remote'
        check 'project_presential'
        click_on 'commit'

        css_beginning = "#project_details ."
        expect(page).to have_css(css_beginning + 'title', text: 'titulo')
        expect(page).to have_css(css_beginning + 'description', text: 'descrição')
        expect(page).to have_css(css_beginning + 'skills_needed', text: 'habilidades')
        expect(page).to have_css(css_beginning + 'max_pay_per_hour', text: 'R$ 234,42')
        expect(page).to have_css(css_beginning + 'open_until', text: '10/11/2022')
        expect(page).to have_css(css_beginning + 'remote', text: 'sim')
        expect(page).to have_css(css_beginning + 'presential', text: 'sim')

        expect(@hirer.projects.length).to be(1)
    end

    it 'and fills in nothing' do 
        visit root_path
        find('#new_project_link').click
        click_on 'commit'

        expect(page).to have_content('não pode ficar em branco', count: 5)
        
    end
end