class Account < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :role, optional: true
  belongs_to :details_info, optional: true
  belongs_to :info_injection_book, optional: true

  has_many :bills, dependent: :destroy

  scope :filter_users, ->(query) do
    joins(:details_info).where("email LIKE :q OR user_code LIKE :q OR number_phone LIKE :q", q: "%#{query}%") if query.present?
  end

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
