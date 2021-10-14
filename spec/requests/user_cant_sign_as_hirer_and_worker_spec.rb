require 'rails_helper'

describe 'Hirer' do
    before(:each) do
        @hirer = Hirer.create!(
            email:'test@mail.com',
            username: 'mister hirer',
            password: '123456'
        )
        login_as @hirer, scope: :hirer
    end

    it 'cannot sign in as worker at the same time' do
        get '/workers/sign_in'
        expect(response).to redirect_to(root_path)
    end

    it 'cannot sign up as worker at the same time' do
        get '/workers/sign_up'
        expect(response).to redirect_to(root_path)
    end
end

describe 'Worker' do
    before(:each) do
        @worker = Worker.create!(
            email:'test@mail.com',
            password: '123456'
        )
        login_as @worker, scope: :worker
    end

    it 'cannot sign in as hirer at the same time' do
        get '/hirers/sign_in'
        expect(response).to redirect_to(root_path)
    end

    it 'cannot sign up as hirer at the same time' do
        get '/hirers/sign_up'
        expect(response).to redirect_to(root_path)
    end
end