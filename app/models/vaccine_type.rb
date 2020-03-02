class VaccineType < ApplicationRecord
  has_many :vaccines, dependent: :destroy
end
