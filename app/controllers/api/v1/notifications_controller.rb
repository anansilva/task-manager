module Api
  module V1
    class NotificationsController < ApplicationController
      include Pagination

      def index
        authorize Notification

        tasks = paginate(
          query: Notification,
          limit: params[:limit],
          offset: params[:offset]
        )

        render json: tasks, status: 200
      end

      def read
        authorize Notification

        notification.update!(status: 1)

        render json: notification, status: 200
      end

      def unread
        authorize Notification

        notification.update!(status: 0)

        render json: notification, status: 200
      end

      private

      def notification
        Notification.find(params[:id])
      end
    end
  end
end
