class Order < ApplicationRecord
  belongs_to :company
  belongs_to :account

  serialize :vaccine_id, Array
  serialize :quantity, Array
end
