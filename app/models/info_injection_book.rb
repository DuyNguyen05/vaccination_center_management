class InfoInjectionBook < ApplicationRecord
  has_many :injection_books, dependent: :destroy
end
