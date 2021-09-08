require 'rails_helper'

describe 'Users', type: :request do
  describe 'POST /signup' do
    context 'when credentials are valid' do
      it 'creates the user' do
        post '/api/v1/signup', params: { email: 'test@test.com', password: 'safe password' }

        expect(response.status).to eq(201)

        body = JSON.parse(response.body).with_indifferent_access

        expect(body[:message]).to eq('Account created successfully!')
      end

      it 'authenticates the user' do
        post '/api/v1/signup', params: { email: 'test@test.com', password: 'safe password' }

        expect(response.status).to eq(201)

        body = JSON.parse(response.body).with_indifferent_access

        expect(body[:auth_token]).to be_present
      end
    end

    context 'when credentials are not valid' do
      it 'no user is created' do
        post '/api/v1/signup', params: { email: 'test@test.com' }

        expect(response.status).to eq(422)
      end
    end
  end
end
