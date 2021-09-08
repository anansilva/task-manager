class TaskPolicy < ApplicationPolicy
  def index?
    user.manager?
  end

  def create?
    user.technician?
  end

  def update?
    user.technician? && record.user_id == user.id
  end

  def show?
    index? || update?
  end
end
