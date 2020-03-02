class InjectionBook < ApplicationRecord
  belongs_to :info_injection_book
  has_many :detail_injection_books, dependent: :destroy
end
