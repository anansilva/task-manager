module Api
  module V1
    class TasksController < ApplicationController
      def index
        authorize Task

        render json: Task.all, status: 200
      end

      def create
        authorize Task

        task = Task.create!(user_id: current_user.id, summary: task_params[:summary])

        render json: task, status: 201
      end

      def update
        authorize task

        task.update!(summary: task_params[:summary])

        render json: task, status: 200
      end

      def show
        authorize task

        render json: task, status: 200
      end

      private

      def task
        @task ||= Task.find_by(id: params[:id])
      end

      def task_params
        params.require(:task).permit(:summary)
      end
    end
  end
end
