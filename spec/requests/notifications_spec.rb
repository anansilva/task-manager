require 'rails_helper'

describe 'Notifications', type: :request do
  describe 'GET /notifications' do
    context 'user is authenticated' do
      let(:user) { create(:user, role: 0) }

      before 'authenticate user' do
        allow(Services::AuthorizeApiRequest).to receive(:call).and_return(user)
      end

      context 'user is a manager' do
        before 'create tasks' do
          create_list(:notification, 2)
        end

        it 'allows the manager to see all notifications' do
          get '/api/v1/notifications'

          expect(response.status).to eq(200)
          expect(JSON.parse(response.body).size).to eq(2)
        end
      end

      context 'user is a technician' do
        let(:user) { create(:user, role: 1) }

        before 'create a task for the technician' do
          create(:task, user: user)
        end

        it 'does not allows the technician to see notifications' do
          get '/api/v1/notifications'

          expect(response.status).to eq(403)
        end
      end
    end

    context 'user is not authenticated' do
      it 'does not allow notifications to be viewed' do
        get '/api/v1/notifications'

        expect(response.status).to eq(401)
      end
    end
  end
end
