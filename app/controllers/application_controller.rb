class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved

  private

  def record_not_saved(e)
    render json: { errors: e.record.errors }, status: 422
  end
end
