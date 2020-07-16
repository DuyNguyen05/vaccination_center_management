class User::DetailInjectionBookPolicy < ApplicationPolicy
  def new?
    user.is_doctor? || user.is_nurse?
  end

  def show?
    user.is_user? || new? || user.is_staff?
  end

  def index?
    new? || user.is_staff?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def create?
    new?
  end
end
