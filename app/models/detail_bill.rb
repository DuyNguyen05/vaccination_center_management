class DetailBill < ApplicationRecord
  belongs_to :vaccine_package, optional: true
  belongs_to :vaccine, optional: true
  belongs_to :bill
end
