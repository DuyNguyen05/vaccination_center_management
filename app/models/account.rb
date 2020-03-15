class Account < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :role, optional: true
  belongs_to :details_info, optional: true

  has_many :bills, dependent: :destroy
end
