class Department < ApplicationRecord
  has_many :details_infos, dependent: :nullify
  has_many :accounts, through: :details_infos

  validates :name, presence: true, uniqueness: true
end
