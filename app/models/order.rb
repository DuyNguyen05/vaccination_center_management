class Order < ApplicationRecord
  after_create :generate_order_code

  belongs_to :company
  belongs_to :account

  has_many :detail_orders, dependent: :destroy

  accepts_nested_attributes_for :detail_orders, allow_destroy: true, reject_if: :all_blank

  private

  def generate_order_code
    source = (0..9).to_a
    code = "ORDER-"
    8.times{ code += source[rand(source.size)].to_s }
    self.code = code
    self.save!
  end

end
