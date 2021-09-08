require 'rails_helper'

describe 'Users', type: :request do
  describe 'POST /authenticate' do
    context 'valid credentials' do
      it 'authenticates the user' do
        user_email = 'test@test.com'
        user_password = 'my very safe password'

        user = create(:user, email: user_email, password: user_password)

        post '/api/v1/authenticate', params: { email: user_email, password: user_password }

        expect(response.status).to eq(200)
      end
    end

    context 'invalid credentials' do
      it 'authenticates the user' do
        user_email = 'test@test.com'
        user_password = 'my very safe password'

        user = create(:user, email: user_email, password: user_password)

        post '/api/v1/authenticate', params: { email: user_email, password: 'random password' }

        expect(response.status).to eq(401)
      end
    end
  end
end
