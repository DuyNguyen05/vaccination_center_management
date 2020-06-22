class User::InjectionBookPolicy < ApplicationPolicy
  def new?
    user.is_current_user? user || user.is_staff?
  end

  def create?
    new?
  end

  def show?
    new?
  end

  def index?
    new?
  end
end
