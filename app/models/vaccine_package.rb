class VaccinePackage < ApplicationRecord
  belongs_to :vaccine_package_type
  has_many :vaccines
  has_many :detail_vaccine_packages
  has_many :injection_books, through: :detail_vaccine_packages
end
