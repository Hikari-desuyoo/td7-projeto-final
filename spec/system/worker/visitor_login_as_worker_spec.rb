require 'rails_helper'

describe 'Visitor login' do
  it 'successfully' do
    existing_worker = create(:worker, :complete)

    visit root_path
    find('#worker_login_link').click
    fill_in 'worker_email', with: existing_worker.email
    fill_in 'worker_password', with: existing_worker.password
    click_on 'commit'

    expect(current_path).to eq root_path
    expect(page).to_not have_css('.signup')
    expect(page).to_not have_css('.login')
    expect(page).to have_css('#welcome_worker')
    click_on 'profileDropdown'
    expect(page).to have_css('#logout_link')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
