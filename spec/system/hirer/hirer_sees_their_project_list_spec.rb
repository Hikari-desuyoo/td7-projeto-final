require 'rails_helper'

describe 'Logged (complete)Hirer' do
  include ActiveSupport::Testing::TimeHelpers

  it 'successfully sees my projects page' do
    Occupation.create!(name: 'dev')

    hirer = create :hirer
    hirer_projects = create_list(:project, 3, hirer: hirer)

    hirer2 = create :hirer
    not_hirer_projects = [create(:project, hirer: hirer2)]

    login_as hirer, scope: :hirer
    visit root_path

    click_on 'my_projects_button'

    hirer_projects.each do |project|
      expect(page).to have_content(project.title)
    end

    not_hirer_projects.each do |project|
      expect(page).to_not have_content(project.title)
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
