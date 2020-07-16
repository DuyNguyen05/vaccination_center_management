class User::VaccinePolicy < ApplicationPolicy
  def index?
    user.is_staff? || user.is_user? || user.is_doctor? || user.is_nurse?
  end
end
