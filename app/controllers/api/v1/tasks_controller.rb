module Api
  module V1
    class TasksController < ApplicationController
      include Pagination

      def index
        tasks = paginate(
          query: policy_scope(Task),
          limit: params[:limit],
          offset: params[:offset]
        )

        render json: tasks, status: 200
      end

      def create
        authorize Task

        task = Task.create!(
          user_id: current_user.id,
          name: task_params[:name],
          summary: task_params[:summary]
        )

        render json: task, status: 201
      end

      def update
        authorize task

        task.update!(
          name: task_params[:name],
          summary: task_params[:summary])

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

      def perform
        authorize task

        task.update!(performed_at: Time.now.utc)
        send_notification_to_manager!

        render json: task, status: 200
      end

      private

      def task
        @task ||= Task.find_by(id: params[:id])
      end

      def task_params
        params.require(:task).permit(:name, :summary)
      end

      def send_notification_to_manager!
        NotificationWorker.perform_async(
          current_user.email,
          task.name,
          task.performed_at
        )
      end
    end
  end
end
