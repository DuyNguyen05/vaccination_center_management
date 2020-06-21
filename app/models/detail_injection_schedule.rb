class DetailInjectionSchedule < ApplicationRecord
  extend Enumerize
  belongs_to :injection_schedule
  belongs_to :vaccine

  enumerize :type_age, in: [:childbirth, :month_old, :year_old], predicates: true, i18n_scope: "type_age", default: :childbirth

  validates :number_injection, presence: true
end
