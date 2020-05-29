class DetailVaccinePackage < ApplicationRecord
  belongs_to :vaccine
  belongs_to :vaccine_package_type
end
