class VaccinePackageType < ApplicationRecord
  has_many :vaccine_packages, dependent: :destroy
end
