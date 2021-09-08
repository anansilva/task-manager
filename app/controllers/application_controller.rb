class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved
  rescue_from Errors::AuthenticationError, with: :user_not_authenticated

  private

  def record_not_saved(e)
    render json: { errors: e.record.errors }, status: 422
  end
  def user_not_authenticated(e)
    render json: { errors: e.message }, status: 401
  end
end
