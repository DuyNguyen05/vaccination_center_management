class Vaccine < ApplicationRecord
  belongs_to :vaccine_type, optional: true
  has_many :detail_injection_books
  has_many :injection_books, through: :detail_injection_books
  has_many :companies
  has_many :accounts

  scope :match_query, ->(query) do
    where("code LIKE :q OR manufacture LIKE :q", q: "%#{query}%") if query.present?
  end

  validates :code, presence: true, uniqueness: true
  validates :manufacture, presence: true
  validates :content, presence: true
  validates :expiry_date, presence: true
  validates :inventory, presence: true
end
