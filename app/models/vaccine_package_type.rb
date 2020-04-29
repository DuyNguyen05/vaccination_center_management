class VaccinePackageType < ApplicationRecord
  has_many :vaccine_packages, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :find_by_name, ->(query) do
    where("name LIKE :q", q: "%#{query}%") if query.present?
  end
end
