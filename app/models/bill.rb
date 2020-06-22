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
  has_many :vaccines, through: :detail_bills

  accepts_nested_attributes_for :detail_bills, allow_destroy: true

  scope :newest, -> {order created_at: :desc}
  
  scope :filter_bill, -> (query) do
    where("injection_book_id LIKE :q OR id LIKE :q OR created_at LIKE :q", q: "%#{query}%") if query.present?
  end

  # Bill.includes(:detail_bills, :vaccines).map{ |a| a.vaccines.sum(:price) }

  # scope :tested, -> (time) do
  #   includes(:detail_bills, :vaccines).where("created_at >= ?", time)
  #     .map{ |a| a.vaccines.sum(:price) }
  # end

  # def tested
  #   includes(:detail_bills, :vaccines).map{ |a| a.created_at, a.vaccines.sum(:price) }
  # end

  private

  def generate_bill_code
    source = (0..9).to_a
    bill_code = "BI"
    8.times{ bill_code += source[rand(source.size)].to_s }
    self.code = bill_code
    self.save!
  end
end
