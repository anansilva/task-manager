module Pagination
  extend ActiveSupport::Concern

  MAX_PAGE_LIMIT = 50.freeze

  def paginate(query:, limit: MAX_PAGE_LIMIT, offset:)
    query.limit(record_limit).offset(offset)
  end

  private

  def record_limit
    [
      params[:limit].to_i,
      MAX_PAGE_LIMIT
    ].min
  end
end
