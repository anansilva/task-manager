module Api
  module V1
    class TasksController < ApplicationController
      def index
        authorize Task

        render json: Task.all
      end
    end
  end
end
