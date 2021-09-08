class NotificationPolicy < ApplicationPolicy
  def index?
    user.manager?
  end
end
