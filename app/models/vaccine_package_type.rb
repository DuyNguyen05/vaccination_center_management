class VaccinePackageType < ApplicationRecord
  has_many :detail_vaccine_packages, dependent: :destroy
  has_many :vaccines, through: :detail_vaccine_packages, dependent: :destroy
  has_many :injection_books, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :find_by_name, ->(query) do
    where("name LIKE :q", q: "%#{query}%") if query.present?
  end
  scope :search_vaccines_packages, ->(query) do
    where("name LIKE :q", q: "%#{query}%") if query.present?
  end
  scope :newest, -> { order(created_at: :desc) }
end
