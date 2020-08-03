class User::BillPolicy < ApplicationPolicy
  def index?
    user.is_staff? || user.is_doctor? || user.is_nurse?
  end

  def new?
    index?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end
end
