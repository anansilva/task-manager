require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    it 'creates the user' do
      expect do
        post :create, params: {
          email: 'a@test.com',
          password: 'safe password'
        }
      end.to change { User.count }.by(1)
    end

    it 'authenticates the user' do
      post :create, params: {
        email: 'test@test.com',
        password: 'safe password',
        role: 0
      }

      body = JSON.parse(response.body).with_indifferent_access

      expect(body[:auth_token]).to be_present
    end

    context 'when creating a manager' do
      it 'returns a success message specific to the manager' do
        post :create, params: {
          email: 'test@test.com',
          password: 'safe password',
          role: 0
        }

        body = JSON.parse(response.body).with_indifferent_access

        expect(body[:message]).to eq('Manager account created successfully!')
      end
    end

    context 'when creating a technician' do
      it 'returns a success message specific to the technician' do
        post :create, params: {
          email: 'test@test.com',
          password: 'safe password',
          role: 1
        }

        body = JSON.parse(response.body).with_indifferent_access

        expect(body[:message]).to eq('Technician account created successfully!')
      end
    end

    context 'when role is not defined' do
      it 'defaults to the technician' do
        post :create, params: {
          email: 'test@test.com',
          password: 'safe password'
        }

        body = JSON.parse(response.body).with_indifferent_access

        expect(body[:message]).to eq('Technician account created successfully!')
      end
    end
  end
end

