class Bill < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :injection_book, optional: true
  has_many :detail_bills, dependent: :destroy
  belongs_to :detail_injection_book

  accepts_nested_attributes_for :detail_bills

  private

  def generate_bill_code
    source = (0..9).to_a
    bill_code = "BILL"
    5.times{ bill_code += source[rand(source.size)].to_s }
    self.bill_code = bill_code
    self.save!
  end
end
