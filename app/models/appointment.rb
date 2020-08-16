class Appointment < ApplicationRecord
	after_create :perform

  belongs_to :injection_book, foreign_key: :book_code, optional: true
  belongs_to :vaccine, class_name: Vaccine.name

  validates :registration_date, presence: true

  scope :newest, -> {order created_at: :desc}
  scope :filter_appointments, ->(query) do
    where("book_code LIKE :q OR registration_date LIKE :q", q: "%#{query}%") if query.present?
  end

  def perform
  	NotifiSenderJob.perform()
  end
end
