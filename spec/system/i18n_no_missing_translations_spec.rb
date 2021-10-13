require 'rails_helper'

describe 'no missing translation' do
    def missing_check
        expect(page).to_not have_css('.translation_missing')
    end

    describe 'as visitor' do
        it 'homepage' do
            visit root_path
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