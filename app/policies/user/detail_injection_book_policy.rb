class User::DetailInjectionBookPolicy < ApplicationPolicy
  def new?
    user.is_admin? || user.is_staff?
  end

  def show?
    new?
  end
end
