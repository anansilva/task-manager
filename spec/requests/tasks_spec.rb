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
      it 'does not allow tasks to be viewed' do
        get '/api/v1/tasks'

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST /tasks' do
    context 'user is authenticated' do
      context 'user is a manager' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(manager)
        end

        let(:manager) { create(:user, role: 0) }

        it 'does not allow the manager to create tasks' do
          post "/api/v1/tasks", params: { task: { user_id: 123, summary: 'test task creation' } }

          expect(response.status).to eq(403)
        end
      end

      context 'user is a technician' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(technician)
        end

        let(:technician) { create(:user, role: 1) }

        it 'allows the technician to create his/her own tasks' do
          post "/api/v1/tasks", params: { task: { summary: 'test task creation' } }

          expect(response.status).to eq(201)
        end
      end
    end

    context 'user is not authenticated' do
      it 'does not allow tasks to be created' do
        post "/api/v1/tasks", params: { task: { summary: 'test task creation' } }

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PUT /tasks/:id' do
    context 'user is authenticated' do
      context 'user is a manager' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(manager)
        end

        let(:manager) { create(:user, role: 0) }
        let(:technician) { create(:user, role: 1) }
        let(:task) { create(:task, user_id: technician.id, summary: 'current summary') }

        it 'does not allow the manager to update tasks' do
          put "/api/v1/tasks/#{task.id}", params: { task: { summary: 'new summary' } }

          expect(response.status).to eq(403)
          expect(task.reload.summary).to eq('current summary')
        end
      end

      context 'user is a technician' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(technician)
        end

        let(:technician) { create(:user, role: 1) }
        let(:task) { create(:task, user_id: technician.id, summary: 'current summary') }

        it 'allows the technician to update his/her own tasks' do
          put "/api/v1/tasks/#{task.id}", params: { task: { summary: 'new summary' } }

          expect(response.status).to eq(200)
        end

        it 'does not allows the technician to update other technicians\' tasks' do
          another_technician = create(:user, role: 1)
          another_task = create(:task, user_id: another_technician.id, summary: 'abc')

          put "/api/v1/tasks/#{another_task.id}", params: { task: { summary: 'new summary' } }

          expect(response.status).to eq(403)
        end
      end
    end

    context 'user is not authenticated' do
      it 'does not allow updates' do
        put "/api/v1/tasks/123", params: { task: { summary: 'new summary' } }

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET /tasks/:id' do
    context 'user is authenticated' do
      context 'user is a manager' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(manager)
        end

        let(:manager) { create(:user, role: 0) }
        let(:technician) { create(:user, role: 1) }
        let(:task) { create(:task, user_id: technician.id, summary: 'current summary') }

        it 'allows the manager to see all technicians\s tasks' do
          get "/api/v1/tasks/#{task.id}"

          expect(response.status).to eq(200)
        end
      end

      context 'user is a technician' do
        before 'authenticate user' do
          allow(Services::AuthorizeApiRequest).to receive(:call).and_return(technician)
        end

        let(:technician) { create(:user, role: 1) }
        let(:task) { create(:task, user_id: technician.id, summary: 'current summary') }

        it 'allows the technician to see his/her own tasks' do
          get "/api/v1/tasks/#{task.id}"

          expect(response.status).to eq(200)
        end

        it 'does not allows the technician to see other technicians\' tasks' do
          another_technician = create(:user, role: 1)
          another_task = create(:task, user_id: another_technician.id, summary: 'abc')

          get "/api/v1/tasks/#{another_task.id}"

          expect(response.status).to eq(403)
        end
      end
    end

    context 'user is not authenticated' do
      it 'does not allow any tasks to be viewed' do
        get "/api/v1/tasks/123"

        expect(response.status).to eq(401)
      end
    end
  end
end
