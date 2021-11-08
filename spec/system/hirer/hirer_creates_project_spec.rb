require 'rails_helper'

describe 'Logged Hirer creates project' do
  before(:each) do
    @hirer = create :hirer

    login_as @hirer, scope: :hirer
  end

  it 'successfully' do
    visit root_path
    find('#new_project_link').click
    within '#new_project_form' do
      fill_in 'project_title', with: 'titulo'
      fill_in 'project_description', with: 'descrição'
      fill_in 'project_skills_needed', with: 'habilidades'
      fill_in 'project_max_pay_per_hour', with: '234.42'
      fill_in 'project_open_until', with: '10/11/2022'
      check 'project_remote'
      check 'project_presential'
      click_on 'commit'
    end

    css_beginning = '#project_details .'
    expect(page).to have_css('.title', text: 'titulo')
    expect(page).to have_css("#{css_beginning}description", text: 'descrição')
    expect(page).to have_css("#{css_beginning}skills_needed", text: 'habilidades')
    expect(page).to have_css("#{css_beginning}max_pay_per_hour", text: 'R$ 234,42')
    expect(page).to have_css("#{css_beginning}open_until", text: '10/11/2022')
    expect(page).to have_css("#{css_beginning}remote", text: 'sim')
    expect(page).to have_css("#{css_beginning}presential", text: 'sim')

    expect(page).to_not have_css('.translation_missing')

    expect(@hirer.projects.length).to be(1)
  end

  it 'and fills in nothing' do
    visit root_path
    find('#new_project_link').click
    within '#new_project_form' do
      click_on 'commit'
    end

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  it 'and fills wrong data type for payment' do
    visit root_path
    find('#new_project_link').click
    within '#new_project_form' do
      fill_in 'project_max_pay_per_hour', with: 'cinquenta conto'
      click_on 'commit'
    end

    expect(page).to have_content('não é um número')
  end

  it 'and fills wrong data type for date' do
    visit root_path
    find('#new_project_link').click
    within '#new_project_form' do
      fill_in 'project_title', with: 'titulo'
      fill_in 'project_description', with: 'descrição'
      fill_in 'project_skills_needed', with: 'habilidades'
      fill_in 'project_max_pay_per_hour', with: '234.42'
      fill_in 'project_open_until', with: 'dia dez' # raises blank error
      check 'project_remote'
      check 'project_presential'
      click_on 'commit'
    end

    expect(page).to have_content('não pode ficar em branco')
  end

  it 'and fills date before current date' do
    visit root_path
    find('#new_project_link').click
    within '#new_project_form' do
      fill_in 'project_title', with: 'titulo'
      fill_in 'project_description', with: 'descrição'
      fill_in 'project_skills_needed', with: 'habilidades'
      fill_in 'project_max_pay_per_hour', with: '234.42'
      fill_in 'project_open_until', with: '23/4/2009'
      check 'project_remote'
      check 'project_presential'
      click_on 'commit'
    end

    expect(page).to have_content('já passou')
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
