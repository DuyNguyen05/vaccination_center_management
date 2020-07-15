class DetailBill < ApplicationRecord
  belongs_to :vaccine_package_type, optional: true
  belongs_to :vaccine
  belongs_to :bill
  belongs_to :wait_number
end
