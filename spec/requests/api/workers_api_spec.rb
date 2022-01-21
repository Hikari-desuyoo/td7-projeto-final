require 'rails_helper'

describe 'Users stats API' do
  context 'GET /api/v1/users_stats' do
    it 'should get users_stats' do
      create_list(:worker, 20)
      create_list(:hirer, 11)

      get '/api/v1/users_stats'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:workers_amount]).to eq(20)
      expect(parsed_body[:hirers_amount]).to eq(11)
    end
  end
end