require 'rails_helper'

describe 'Logged (complete)Worker searchs for project' do
  include ActiveSupport::Testing::TimeHelpers
  before(:each) do
    Occupation.create!(name: 'dev')

    @worker = create(:worker, :complete)
    @hirer1 = create(:hirer)
    @hirer2 = create(:hirer)

    @projects = [
      Project.create!(
        title: 'titulo',
        description: 'descrição',
        skills_needed: 'habilidades',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: @hirer1
      ),
      Project.create!(
        title: 'titULO2',
        description: 'me ache',
        skills_needed: 'habilidades2',
        max_pay_per_hour: '123',
        open_until: 3.days.from_now,
        hirer: @hirer1
      ),
      Project.create!(
        title: 'outra_coisa',
        description: 'descrição3',
        skills_needed: 'mE AcHe',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: @hirer2
      ),
      Project.create!(
        title: 'titulo',
        description: 'titulo',
        skills_needed: 'titulo',
        max_pay_per_hour: '123',
        open_until: 1.day.from_now,
        hirer: @hirer2
      )
    ]
  end

  def search_for(term)
    within('#search_bar') do
      fill_in 'search_term', with: term
      click_on 'commit'
    end
  end

  it 'by title successfully' do
    travel 3.days do
      login_as @worker, scope: :worker
      visit root_path
      search_for('titulo')
      match_projects = [@projects[0], @projects[1]]
      non_match_projects = @projects - match_projects

      match_projects.each do |project|
        expect(page).to have_css(".project_#{project.id}")
      end

      non_match_projects.each do |project|
        expect(page).to_not have_css(".project_#{project.id}")
      end
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'by other text informations successfully' do
    login_as @worker, scope: :worker
    visit root_path

    search_for('me ache')

    [@projects[1], @projects[2]].each do |project|
      expect(page).to have_css(".project_#{project.id}")
    end

    expect(page).to_not have_css('.translation_missing')
  end

  it 'and finds nothing' do
    login_as @worker, scope: :worker
    visit root_path

    search_for('batatinha')

    expect(page).to have_css('#no_results')
    expect(page).to have_content(I18n.t('search.search.no_results'))

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
