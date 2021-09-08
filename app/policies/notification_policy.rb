class NotificationPolicy < ApplicationPolicy
  def index?
    user.manager?
  end

  def mark_as_read?
    user.manager?
  end

  def mark_as_unread?
    mark_as_read?
  end
end
