class User::AccountPolicy < ApplicationPolicy
  def edit?
    user.is_current_user? record
  end
end
