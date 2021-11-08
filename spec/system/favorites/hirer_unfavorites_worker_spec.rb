require 'rails_helper'

describe 'hirer unfavorites worker' do
  before(:each) do
    @worker = create(:worker, :complete)
    @hirer = create(:hirer)

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

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(@hirer.favorited_workers.where(worker: @worker).length).to eq(0)
  end
end
