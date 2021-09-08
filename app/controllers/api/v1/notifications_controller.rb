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
    end
  end
end
