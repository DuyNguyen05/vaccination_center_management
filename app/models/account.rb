class Account < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :role, optional: true
  belongs_to :details_info, optional: true
  belongs_to :info_injection_book, optional: true

  has_many :bills, dependent: :destroy

  def is_current_user? user
    self == user
  end

  def is_staff?
    role.staff?
  end

  def is_admin?
    role.admin?
  end

  def is_super_admin?
    role.super_admin?
  end

  def is_user?
    role.user?
  end
end
