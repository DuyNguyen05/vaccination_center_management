class User::VaccinePolicy < ApplicationPolicy
  def index?
    user.is_staff? || user.is_user?
  end
end
