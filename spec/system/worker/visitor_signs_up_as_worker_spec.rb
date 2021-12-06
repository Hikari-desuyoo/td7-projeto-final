require 'rails_helper'

describe 'Visitor signs up' do
  it 'successfully' do
    visit root_path
    find('#worker_signup_link').click
    fill_in 'worker_email', with: 'test@mail.com'
    fill_in 'worker_password', with: '123456789'
    fill_in 'worker_password_confirmation', with: '123456789'
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
