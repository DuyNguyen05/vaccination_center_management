class User::InfoInjectionBookPolicy < ApplicationPolicy
  def index?
    user.is_admin? || user.is_staff?
  end

  def new?
    index?
  end

  def create?
    index?
  end
end
