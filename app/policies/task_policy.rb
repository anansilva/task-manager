class TaskPolicy < ApplicationPolicy
  def index?
    user.manager?
  end
end
