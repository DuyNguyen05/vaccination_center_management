class Bill < ApplicationRecord
  belongs_to :account
  belongs_to :injection_book
  belongs_to :detail_bill
end
