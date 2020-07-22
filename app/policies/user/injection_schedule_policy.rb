class User::InjectionSchedulePolicy < ApplicationPolicy
  def new?
    user.is_staff? || user.is_doctor? || user.is_nurse? || user.is_user?
  end

  def show?
    new?
  end

  def index?
    new?
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

  def schedule?
    user.is_staff? || user.is_doctor? || user.is_nurse? || user.is_user?
  end
end
