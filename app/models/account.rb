class Account < ApplicationRecord
  devise :database_authenticatable

  belongs_to :role
  belongs_to :details_info

  has_many :bills, dependent: :destroy
end