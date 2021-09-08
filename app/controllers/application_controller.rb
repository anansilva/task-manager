class ApplicationController < ActionController::API
  before_action :authorize_request

  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved
  rescue_from Errors::AuthenticationError, with: :user_not_authenticated
  rescue_from Errors::AuthorizationTokenError, with: :request_not_authorized

  private

  def authorize_request
    Services::AuthorizeApiRequest.call(headers: request.headers)
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
end
