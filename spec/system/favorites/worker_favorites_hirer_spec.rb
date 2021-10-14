require 'rails_helper'

describe 'worker favorites worker' do
    before(:each) do
        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27'
        )

        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit "/hirers/#{@hirer.id}"

        click_on 'favorite_button'

        expect(page).to have_css('#unfavorite_button')

        expect(page).to_not have_css('.translation-missing')
        expect(page).to_not have_content('translation missing')
        expect(@worker.favorited_hirers.where(hirer: @hirer).length).to eq(1)
    end
end