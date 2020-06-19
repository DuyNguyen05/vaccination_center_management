class InjectionSchedule < ApplicationRecord
  has_many :detail_injection_schedules, dependent: :destroy

  validates :injection_schedule_type, presence: true

  accepts_nested_attributes_for :detail_injection_schedules, allow_destroy: true
end
