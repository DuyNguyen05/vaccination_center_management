class Vaccine < ApplicationRecord
  belongs_to :vaccine_type
  has_many :detail_injection_books
  has_many :injection_books, through: :detail_injection_books
end
