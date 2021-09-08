module Api
  module V1
    class AuthenticationController < ApplicationController
      def authenticate
        auth_token = authenticate_user!
        render json: { auth_token: auth_token }
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
