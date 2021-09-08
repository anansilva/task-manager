module Services
  class EncodeJsonWebToken
    include Concerns::Callable

    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def initialize(payload:, expires_at: 24.hours.from_now)
      @payload = payload
      @expires_at = expires_at
    end

    def call
      payload[:exp] = expires_at.to_i

      JWT.encode(payload, HMAC_SECRET)
    end

    private

    attr_reader :payload, :expires_at
  end
end
