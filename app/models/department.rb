class Department < ApplicationRecord
  has_many :details_infos, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
