class DetailBill < ApplicationRecord
  belongs_to :vaccine_package_type, optional: true
  belongs_to :vaccine
  belongs_to :bill
  # belongs_to :account

  validates :number_injection, presence: true
  validates :next_appointment, presence: true

  validate :validate_next_appointment

  private

  def validate_next_appointment
    next_appointment > Time.now
  end

  def total_price
    vaccine.price * number_injection
 end

end
