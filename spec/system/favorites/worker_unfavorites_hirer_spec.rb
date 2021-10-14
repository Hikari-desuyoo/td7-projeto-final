require 'rails_helper'

describe 'worker unfavorites hirer' do
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

        FavoritedHirer.create!(
            hirer: @hirer,
            worker: @worker
        )
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit "/hirers/#{@hirer.id}"

        click_on 'unfavorite_button'

        expect(page).to have_css('#favorite_button')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
        expect(@worker.favorited_hirers.where(hirer: @hirer).length).to eq(0)
    end
end