require 'rails_helper'

describe 'worker cant favorite worker' do
    before(:each) do
        @worker = create(:worker, :complete)
        @hirer = create(:hirer)
    end

    it 'successfully' do
        login_as @worker, scope: :worker
        visit "/workers/#{@worker.id}"

        expect(page).to_not have_css('#favorite_button')

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
        expect(@worker.favorited_hirers.where(hirer: @hirer).length).to eq(0)
    end
end