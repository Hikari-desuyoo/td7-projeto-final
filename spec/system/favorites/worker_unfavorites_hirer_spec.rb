require 'rails_helper'

describe 'worker unfavorites' do
  before(:each) do
    @worker = create(:worker, :complete)
    @hirer = create(:hirer)

    FavoritedHirer.create!(
      hirer: @hirer,
      worker: @worker
    )
  end

  it 'hirer successfully' do
    login_as @worker, scope: :worker
    visit "/hirers/#{@hirer.id}"

    click_on 'unfavorite_button'

    expect(page).to have_css('#favorite_button')

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(@worker.favorited_hirers.where(hirer: @hirer).length).to eq(0)
  end
end
