require 'rails_helper'

describe 'Projects API GET /api/v1/projects' do
  context 'authorized hirer' do
    it 'should get hirer projects' do
      create_list(:project, 8)
      hirer = create(:hirer)
      create_list(:project, 2, hirer: hirer)

      get '/api/v1/projects',
           headers: { hirerToken: hirer.user_jwt }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:projects].count).to eq(2)
    end

    it 'should get hirer projects even when its empty' do
      create_list(:project, 8)
      hirer = create(:hirer)

      get '/api/v1/projects',
            headers: { hirerToken: hirer.user_jwt }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:projects].count).to eq(0)
    end
  end
end
