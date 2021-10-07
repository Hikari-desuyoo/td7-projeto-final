require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('Lance')
    expect(page).to have_css('#welcome')
  end
end