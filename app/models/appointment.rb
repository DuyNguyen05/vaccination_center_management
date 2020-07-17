class Appointment < ApplicationRecord
  belongs_to :injection_book, foreign_key: :book_code, optional: true
end
