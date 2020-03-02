class DetailInjectionBook < ApplicationRecord
  belongs_to :vaccination_center
  belongs_to :account
  belongs_to :vaccine
  belongs_to :vaccine_package
  belongs_to :injection_book
end
