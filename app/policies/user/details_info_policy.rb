class User::DetailsInfoPolicy < ApplicationPolicy
  def new?
    user.is_staff?
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
end
