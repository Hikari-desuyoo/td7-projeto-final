require 'rails_helper'

describe 'hirer favorites worker' do
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
        login_as @hirer, scope: :hirer
        visit "/workers/#{@worker.id}"

        click_on 'favorite_button'

        expect(page).to have_css('#unfavorite_button')
        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
        expect(@hirer.favorited_workers.where(worker: @worker).length).to eq(1)
    end
end