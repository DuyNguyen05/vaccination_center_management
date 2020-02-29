class VaccinationCenter < ApplicationRecord
  has_many :injection_schedules, dependent: :destroy
  has_many :details_info
  has_many :detail_injection_books
end
