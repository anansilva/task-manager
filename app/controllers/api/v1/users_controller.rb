module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize_request

      def create
        user = User.create!(user_params)
        auth_token = authenticate_user!

        render json: {
          message: 'Account created successfully!',
          auth_token: auth_token,
        }, status: 201
      end

      private

      def authenticate_user!
        Services::AuthenticateUser.call(
          email: user_params[:email],
          password: user_params[:password]
        )
      end

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
