class DetailOrder < ApplicationRecord

  class << self
    def search_csv_column_definitions
      [
        {
          header: DetailOrder.human_attribute_name(:vaccine_id),
          value: proc { |detail_order| detail_order.vaccine_id },
        },
        {
          header: DetailOrder.human_attribute_name(:quantity),
          value: proc { |detail_order| detail_order.quantity },
        },
      ]
    end
  end
end
