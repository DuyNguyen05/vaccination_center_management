class User::AccountPolicy < ApplicationPolicy
  def index?
    user.is_staff?
  end

  def edit?
    user.is_current_user? record
  end
end
