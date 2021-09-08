module Api
  module V1
    class TasksController < ApplicationController
      MAX_PAGE_LIMIT = 50.freeze

      def index
        authorize Task

        tasks = Task.limit(record_limit).offset(params[:offset])

        render json: tasks, status: 200
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

      def destroy
        authorize task

        task.destroy!

        render json: {}, status: 204
      end

      private

      def record_limit
        return MAX_PAGE_LIMIT unless params[:limit]

        [
          params[:limit].to_i,
          MAX_PAGE_LIMIT
        ].min
      end

      def task
        @task ||= Task.find_by(id: params[:id])
      end

      def task_params
        params.require(:task).permit(:summary)
      end
    end
  end
end
