class ApplicationController < ActionController::API
  include Pundit
  before_action :authorize_request

  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved
  rescue_from Errors::AuthenticationError, with: :user_not_authenticated
  rescue_from Errors::AuthorizationTokenError, with: :request_not_authorized
  rescue_from Pundit::NotAuthorizedError, with: :no_permission

  attr_reader :current_user

  private

  def authorize_request
    @current_user = Services::AuthorizeApiRequest.call(headers: request.headers)
  end

  def record_not_saved(e)
    render json: { errors: e.record.errors }, status: 422
  end

  def user_not_authenticated(e)
    render json: { errors: e.message }, status: 401
  end

  def request_not_authorized(e)
    render json: { errors: e.message }, status: 401
  end

  def no_permission(e)
    render json: { errors: e.message }, status: 403
  end
end
