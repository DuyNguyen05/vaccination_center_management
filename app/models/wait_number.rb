class WaitNumber < ApplicationRecord
  belongs_to :doctor, class_name: "Account"
  belongs_to :nurse, class_name: "Account", optional: true
  belongs_to :injection_book
  has_one :detail_bill
end
