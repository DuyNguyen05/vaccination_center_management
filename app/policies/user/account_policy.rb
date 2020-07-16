class User::AccountPolicy < ApplicationPolicy
  def index?
    user.is_staff? || user.is_doctor? || user.is_nurse?
  end

  def edit?
    user.is_current_user? record
  end
end
