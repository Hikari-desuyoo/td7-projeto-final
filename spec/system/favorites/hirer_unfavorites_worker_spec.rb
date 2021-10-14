require 'rails_helper'

describe 'hirer unfavorites worker' do
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

        FavoritedWorker.create!(
            hirer: @hirer,
            worker: @worker
        )
    end

    it 'successfully' do
        login_as @hirer, scope: :hirer
        visit "/workers/#{@worker.id}"

        click_on 'unfavorite_button'

        expect(page).to have_css('#favorite_button')

        expect(page).to_not have_css('.translation-missing')
        expect(page).to_not have_content('translation missing')
        expect(@hirer.favorited_workers.where(worker: @worker).length).to eq(0)
    end
end