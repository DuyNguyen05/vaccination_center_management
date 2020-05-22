class Vaccine < ApplicationRecord
  belongs_to :vaccine_type, optional: true
  has_many :detail_injection_books
  has_many :injection_books, through: :detail_injection_books

  enum tag: {default: "default", other: "other"}

  scope :newest, -> { order(created_at: :desc) }
end
