require 'rails_helper'


describe 'Logged (complete)Worker visits project page' do    
    before(:each) do
        Occupation.create!(name: 'dev')

        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27'
        )

        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789'
        )

        @project = Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            )

        login_as @worker, scope: :worker
        visit root_path
        click_on @project.title
    end

    it 'and sees apply button' do
        
        expect(page).to have_css('.apply_button')     
        expect(page).to_not have_css('.translation_missing')

    end
end
