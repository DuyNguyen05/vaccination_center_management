class DetailBill < ApplicationRecord
  belongs_to :vaccine_package
  belongs_to :vaccine
end
