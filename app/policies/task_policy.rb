class TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.technician?
  end

  def update?
    user.technician? && record.user_id == user.id
  end

  def show?
    user.manager? || update?
  end

  def destroy?
    user.manager?
  end

  class Scope < TaskPolicy
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.manager?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
