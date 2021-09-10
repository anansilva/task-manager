class NotificationPolicy < ApplicationPolicy
  def index?
    user.manager?
  end

  def read?
    user.manager?
  end

  def unread?
    read?
  end
end
