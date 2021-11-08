require 'rails_helper'

describe 'Visitor login' do
  def visit_login_page
    visit root_path
    find('#hirer_login_link').click
  end

  it 'successfully' do
    hirer = create :hirer

    visit_login_page
    fill_in 'hirer_email', with: hirer.email
    fill_in 'hirer_password', with: hirer.password
    click_on 'commit'

    expect(current_path).to eq root_path
    expect(page).to_not have_css('.signup')
    expect(page).to_not have_css('.login')
    expect(page).to have_css('#welcome_hirer')
    expect(page).to have_css('#logout_link')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
    expect(page).to_not have_css('.no_projects_notice')
    expect(page).to_not have_css('.homepage_projects')
  end
end
