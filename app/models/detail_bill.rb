class DetailBill < ApplicationRecord
  belongs_to :vaccine_package_type, optional: true
  belongs_to :vaccine
  belongs_to :bill
end
