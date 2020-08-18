class DetailOrder < ApplicationRecord
  belongs_to :vaccine
  belongs_to :order

  validates :vaccine_id, presence: true
  validates :quantity, presence: true

  class << self
    def search_csv_column_definitions
      [
        {
          header: DetailOrder.human_attribute_name(:vaccine_name),
          value: proc { |detail_order| detail_order.vaccine.name },
        },
        {
          header: DetailOrder.human_attribute_name(:code),
          value: proc { |detail_order| detail_order.vaccine.code },
        },
        {
          header: DetailOrder.human_attribute_name(:quantity),
          value: proc { |detail_order| detail_order.quantity },
        },
      ]
    end
  end
end
