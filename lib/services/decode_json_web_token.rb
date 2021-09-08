module Services
  class DecodeJsonWebToken
    include Concerns::Callable

    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def initialize(token:)
      @token = token
    end

    def call
      payload= JWT.decode(token, HMAC_SECRET)[0]
      payload.with_indifferent_access

    rescue JWT::DecodeError => e
      raise Errors::AuthorizationTokenError, e.message
    end

    private

    attr_reader :token
  end
end
