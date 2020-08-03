class Appointment < ApplicationRecord
  belongs_to :injection_book, foreign_key: :book_code, optional: true
  belongs_to :vaccine, class_name: Vaccine.name, foreign_key: :vaccine

  scope :newest, -> {order created_at: :desc}
  scope :filter_appointments, ->(query) do
    joins(:injection_book).where("injection_books.book_code LIKE :q OR registration_date LIKE :q", q: "%#{query}%") if query.present?
  end
end
