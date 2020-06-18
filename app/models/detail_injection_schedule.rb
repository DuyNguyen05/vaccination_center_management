class DetailInjectionSchedule < ApplicationRecord
  belongs_to :injection_schedule
  belongs_to :vaccine

  validates :number_injection, presence: true
end
