require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('Hiring')
    expect(page).to have_css('#welcome')
    expect(page).to_not have_css('.translation_missing')
    expect(page).to_not have_css('.homepage_projects')
  end
end
