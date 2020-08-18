class User::BillPolicy < ApplicationPolicy
  def index?
    user.is_staff?
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

  def export_bill?
    index?
  end
end
