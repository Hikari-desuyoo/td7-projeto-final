require 'rails_helper'

describe 'Logged (complete)Worker' do
  include ActiveSupport::Testing::TimeHelpers

  it 'sees all projects on homepage' do
    Occupation.create!(name: 'dev')

    worker = create(:worker, :complete)
    hirer1 = create(:hirer)
    hirer2 = create(:hirer)

    projects = [
      create(:project,
        title: 'titulo',
        description: 'descrição',
        skills_needed: 'habilidades',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: hirer1),
      create(:project,
        title: 'titulo2',
        description: 'descrição2',
        skills_needed: 'habilidades2',
        max_pay_per_hour: '123',
        open_until: 2.days.from_now,
        hirer: hirer1),
      create(:project,
        title: 'titulo3',
        description: 'descrição3',
        skills_needed: 'habilidades3',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: hirer2)
    ]

    login_as worker, scope: :worker
    visit root_path

    projects.each do |project|
      expect(page).to have_css(".project_#{project.id}")
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'sees all open projects on homepage' do
    Occupation.create!(name: 'dev')

    worker = create(:worker, :complete)
    hirer1 = create(:hirer)
    hirer2 = create(:hirer)

    projects = [
      create(:project,
        title: 'titulo',
        description: 'descrição',
        skills_needed: 'habilidades',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: hirer1),
      create(:project,
        title: 'titulo2',
        description: 'descrição2',
        skills_needed: 'habilidades2',
        max_pay_per_hour: '123',
        open_until: 2.days.from_now,
        hirer: hirer1),
      create(:project,
        title: 'titulo3',
        description: 'descrição3',
        skills_needed: 'habilidades3',
        max_pay_per_hour: '123',
        open_until: 5.days.from_now,
        hirer: hirer2)
    ]

    login_as worker, scope: :worker

    travel 4.days do
      visit root_path
      [projects[0], projects[2]].each do |project|
        expect(page).to have_css(".project_#{project.id}")
      end
      expect(page).to_not have_css(".project_#{projects[1].id}")
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
