require 'rails_helper'

describe 'hirer favorites worker' do
  it 'successfully' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)
    login_as hirer, scope: :hirer
    visit "/workers/#{worker.id}"

    click_on 'favorite_button'

    expect(page).to have_css('#unfavorite_button')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(hirer.favorited_workers.where(worker: worker).length).to eq(1)
  end
end
