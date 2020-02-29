class Account < ApplicationRecord
  belongs_to :role
  belongs_to :details_info

  has_many :bills, dependent: :destroy
end
