require 'rails_helper'

describe Api::V1::TasksController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user, role: 0) }

    before 'authenticate user' do
      allow(Services::AuthorizeApiRequest).to receive(:call).and_return(user)
    end

    before 'create tasks' do
      create_list(:task, 4)
    end

    it 'returns a subset of the tasks based on limit' do
      get :index, params: { limit: 1 }

      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns a subset of the tasks based on limit and offset' do
      get :index, params: { limit: 2, offset: 3 }

      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'has a maximum limit of 50' do
      expect(Task).to receive(:limit).with(50).and_call_original

      get :index, params: { limit: 100 }
    end
  end

  describe 'POST #perform' do
    let(:user) { create(:user, role: 1) }
    let(:task) { create(:task, user: user, name: 'test', performed_at: 2.seconds.ago) }

    before 'authenticate user' do
      allow(Services::AuthorizeApiRequest).to receive(:call).and_return(user)
    end

    it 'creates a job to be processed asynchronously' do
      expect(NotificationWorker).to receive(:perform_async)

      post :perform, params: { id: task.id }
    end
  end
end

