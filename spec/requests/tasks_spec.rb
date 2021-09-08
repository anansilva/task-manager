require 'rails_helper'

describe 'Tasks', type: :request do
  describe 'GET /tasks' do
    context 'user is authenticated' do
      before 'authenticate user' do
        user = create(:user)
        allow(Services::AuthorizeApiRequest).to receive(:call).and_return(user)
      end

      it 'returns all books' do
        get '/api/v1/tasks'

        expect(response.status).to eq(200)
      end
    end

    context 'user is not authenticated' do
      it 'returns all books' do
        get '/api/v1/tasks'

        expect(response.status).to eq(401)
      end
    end
  end
end
