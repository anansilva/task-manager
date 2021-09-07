module Api
  module V1
    class TasksController < ApplicationController
      def index
        render json: Task.all
      end
    end
  end
end
