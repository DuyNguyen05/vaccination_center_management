class DetailVaccinePackage < ApplicationRecord
  belongs_to :vaccine
  belongs_to :vaccine_package_type

  validates :vaccine_id, uniqueness: true

  scope :filter_vaccine, ->(query) do
    joins(:vaccine).where("vaccine_id LIKE :q OR vaccines.name LIKE :q", q: "%#{query}%") if query.present?
  end
end
