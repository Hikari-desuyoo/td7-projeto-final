require 'rails_helper'

describe 'Hirer API generate jwt' do
  context 'POST /api/v1/hirers/generate_token' do
    it 'successfully' do
      create_list(:hirer, 8)

      hirer = create(
        :hirer,
        email: 'hirer@mail.com',
        password: '12345678a'
      )

      credentials = {
        email: 'hirer@mail.com',
        password: '12345678a'
      }

      post '/api/v1/hirers/generate_token',
           params: { credentials: credentials }

      received_jwt = JwtService.decode parsed_body[:jwt]

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(received_jwt.first['sub']).to eq(hirer.email)
    end

    it 'unless credentials are wrong' do
      create_list(:hirer, 8)

      create(
        :hirer,
        email: 'hirer@mail.com',
        password: '12345678a'
      )

      credentials = {
        email: 'hiredsfr@mail.com',
        password: '123456dsf78a'
      }

      post '/api/v1/hirers/generate_token',
           params: { credentials: credentials }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(parsed_body).to eq({})
    end
  end
end
