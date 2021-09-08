class TaskPolicy < ApplicationPolicy
  def index?
    user.manager?
  end

  def create?
    user.technician?
  end
end
