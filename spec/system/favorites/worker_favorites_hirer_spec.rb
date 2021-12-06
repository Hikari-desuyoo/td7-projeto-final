require 'rails_helper'

describe 'worker favorites hirer' do

  it 'successfully' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)

    login_as worker, scope: :worker
    visit "/hirers/#{hirer.id}"

    click_on 'favorite_button'

    expect(page).to have_css('#unfavorite_button')

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(worker.favorited_hirers.where(hirer: hirer).length).to eq(1)
  end
end
