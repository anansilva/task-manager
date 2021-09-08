module Services
  class AuthenticateUser
    include Concerns::Callable

    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      validate_authentication!
    end

    private

    attr_reader :email, :password

    def validate_authentication!
      return auth_token if user && user.authenticate(password)

      raise Errors::AuthenticationError, 'Invalid email or password'
    end

    def user
      @user ||= User.find_by(email: email)
    end

    def auth_token
      Services::EncodeJsonWebToken.call(payload: { user_id: user.id })
    end
  end
end
