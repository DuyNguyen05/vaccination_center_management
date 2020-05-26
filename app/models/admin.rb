class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :role
  belongs_to :details_info, optional: true

  def active_for_authentication?
    super && self.role.admin? # i.e. super && self.is_active
  end

  def inactive_message
    I18n.t("devise.failure.locked")
  end
end
