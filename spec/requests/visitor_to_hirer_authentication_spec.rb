require 'rails_helper'

describe 'Visitor' do
    it 'cannot create project' do
        post '/projects'
        expect(response).to redirect_to(new_hirer_session_path)
    end
    
    it 'cannot open project form' do
        get '/projects/new'
        expect(response).to redirect_to(new_hirer_session_path)
    end

    it 'cannot search projects' do
        get '/search'
        expect(response).to redirect_to('/')
    end
end