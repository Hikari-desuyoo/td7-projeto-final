require 'rails_helper'

describe 'hirer cant favorite hirer' do
  it 'successfully' do
    worker = create(:worker, :complete)
    hirer = create(:hirer)

    login_as hirer, scope: :hirer
    visit "/hirers/#{hirer.id}"

    expect(page).to_not have_css('#favorite_button')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(hirer.favorited_workers.where(worker: worker).length).to eq(0)
  end
end
