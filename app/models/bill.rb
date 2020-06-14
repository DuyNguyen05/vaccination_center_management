class Bill < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :injection_book, optional: true
  has_many :detail_bills
  belongs_to :detail_injection_book

  accepts_nested_attributes_for :detail_bills
end
