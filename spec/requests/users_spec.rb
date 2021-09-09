require 'rails_helper'

describe 'Users', type: :request do
  describe 'POST /signup' do
    context 'when credentials are valid' do
      it 'signs up the user' do
        post '/api/v1/signup',
          params: { email: 'test@test.com', password: 'safe password', role: 1 }

        expect(response.status).to eq(201)
      end
    end

    context 'when password is not sent' do
      it 'does not sign up the user' do
        post '/api/v1/signup', params: { email: 'test@test.com' }

        expect(response.status).to eq(422)
      end
    end

    context 'when email is not sent' do
      it 'does not sign up the user' do
        post '/api/v1/signup', params: { password: 'test@test.com' }

        expect(response.status).to eq(422)
      end
    end
  end
end
