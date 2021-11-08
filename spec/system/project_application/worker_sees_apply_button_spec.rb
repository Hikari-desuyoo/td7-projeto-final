require 'rails_helper'

describe 'Logged (complete)Worker visits project page' do
  include ActiveSupport::Testing::TimeHelpers
  before(:each) do
    Occupation.create!(name: 'dev')

    @worker = create(:worker, :complete)
    @hirer = create(:hirer)
    @project = create(:project, hirer: @hirer)

    login_as @worker, scope: :worker
  end

  it 'and sees status + apply button' do
    visit root_path
    click_on @project.title

    expect(page).to have_content(I18n.t('projects.show.open_project'))
    expect(page).to have_css('#project_application_form')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'does not see apply button if project is closed' do
    travel 10.days do
      visit "/projects/#{@project.id}"

      expect(page).to_not have_css('#project_application_form')
      expect(page).to have_content(I18n.t('projects.show.closed_project'))
      expect(page.body).to_not include('translation-missing')
      expect(page.body).to_not include('translation missing')
    end
  end
end
