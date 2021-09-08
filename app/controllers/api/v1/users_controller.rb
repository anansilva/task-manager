module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.create!(user_params)
        authenticate_user!(user)

        render json: {
          message: 'Account created successfully!',
          auth_token: encode_jwt(user)
        }, status: 201
      end

      private

      def authenticate_user!(user)
        return user if user.authenticate(user.password)
      end

      def encode_jwt(user)
        payload = {
          user_id: user.id,
          exp: 24.hours.from_now.to_i
        }

        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
