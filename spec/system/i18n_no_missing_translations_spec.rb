require 'rails_helper'

describe 'no missing translation' do
  def missing_check
    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  describe 'as visitor' do
    it 'homepage' do
      visit root_path
      missing_check
    end

    it 'worker login page' do
      visit new_worker_session_path
      missing_check
    end

    it 'hirer login page' do
      visit new_hirer_session_path
      missing_check
    end

    it 'hirer signup page' do
      visit new_hirer_registration_path
      missing_check
    end

    it 'worker signup page' do
      visit new_worker_registration_path
      missing_check
    end
  end

  describe 'as hirer' do
    before(:each) do
      @hirer = Hirer.create!(
        email: 'test@mail.com',
        password: '123456789',
        username: 'mister hirer'
      )

      login_as @hirer, scope: :hirer
    end

    it 'homepage' do
      visit root_path
      missing_check
    end

    it 'project/new' do
      visit new_project_path
      missing_check
    end
  end

  describe 'as worker' do
    before(:each) do
      @worker = Worker.create!(
        email: 'test@mail.com',
        password: '123456789'
      )

      login_as @worker, scope: :worker
    end

    it 'homepage' do
      visit root_path
      missing_check
    end
  end
end
