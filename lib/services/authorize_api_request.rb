module Services
  class AuthorizeApiRequest
    include Concerns::Callable

    def initialize(headers:)
      @headers = headers
    end

    def call
      @user ||= User.find(decoded_auth_token[:user_id])

    rescue ActiveRecord::RecordNotFound => e
      raise_invalid_token_error!(e.message)
    end

    private

    attr_reader :headers

    def decoded_auth_token
      Services::DecodeJsonWebToken.call(token: token)
    end

    def token
      validate_header!

      return headers['Authorization'].split(' ').last
    end

    def validate_header!
      return if headers['Authorization'].present?

      raise_invalid_token_error!('Authorization token can\'t be blank!' )
    end

    def raise_invalid_token_error!(message)
      raise Errors::AuthorizationTokenError, message
    end
  end
end
