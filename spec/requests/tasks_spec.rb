require 'rails_helper'

describe 'Tasks', type: :request do
  describe 'GET /tasks' do
    context 'user is authenticated' do
      before 'authenticate user' do
        allow(Services::AuthorizeApiRequest).to receive(:call).and_return(user)
      end

      context 'user is a manager' do
        let(:user) { create(:user, role: 0) }

        it 'allows the manager to see all tasks' do
          get '/api/v1/tasks'

          expect(response.status).to eq(200)
        end
      end

      context 'user is a technician' do
        let(:user) { create(:user, role: 1) }

        it 'does not allow the technician to see all tasks' do
          get '/api/v1/tasks'

          expect(response.status).to eq(403)
        end
      end
    end

    context 'user is not authenticated' do
      it 'returns all tasks' do
        get '/api/v1/tasks'

        expect(response.status).to eq(401)
      end
    end
  end
end
