require 'rails_helper'

describe 'Tasks', type: :request do
  describe 'GET tasks' do
    it 'returns http success' do
      get '/api/v1/tasks'

      expect(response.status).to eq(200)
    end
  end
end
