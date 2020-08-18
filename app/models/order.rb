class Order < ApplicationRecord
  after_create :generate_order_code

  belongs_to :company
  belongs_to :account

  has_many :detail_orders, dependent: :destroy

  accepts_nested_attributes_for :detail_orders, allow_destroy: true, reject_if: :all_blank

  private

  def generate_order_code
    source = (0..9).to_a
    order_code = "ORDER-"
    8.times{ order_code += source[rand(source.size)].to_s }
    order = Order.find_by code: order_code
    while order.present? do
      order_code = "ORDER-"
      8.times{ order_code += source[rand(source.size)].to_s }
      order = Order.find_by code: order_code
    end
    order_code
    self.code = order_code
    self.save!
  end


end
