class Bill < ApplicationRecord
  after_create :generate_bill_code

  belongs_to :account, optional: true
  belongs_to :injection_book, optional: true
  belongs_to :doctor, class_name: Account.name, foreign_key: :doctor_id, optional: true
  belongs_to :cashier, class_name: Account.name, foreign_key: :cashier_id, optional: true
  belongs_to :nurse, class_name: Account.name, foreign_key: :nurse_id, optional: true
  has_many :detail_bills, dependent: :destroy
  has_many :vaccines, through: :detail_bills
  belongs_to :detail_injection_book

  accepts_nested_attributes_for :detail_bills, allow_destroy: true

  scope :newest, -> {order created_at: :desc}
  scope :filter_bills, ->(query) do
    where("code LIKE :q", q: "%#{query}%") if query.present?
  end

  private

  def generate_bill_code
    source = (0..9).to_a
    bill_code = "BILL"
    8.times{ bill_code += source[rand(source.size)].to_s }
    bill = Bill.find_by code: bill_code
    while bill.present? do
      bill_code = "BILL"
      8.times{ bill_code += source[rand(source.size)].to_s }
      bill = Bill.find_by code: bill_code
    end
    bill_code
    self.code = bill_code
    self.save!
  end
end
