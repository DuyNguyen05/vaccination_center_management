class Company < ApplicationRecord

  belongs_to :vaccine, optional: true

  scope :match_query, ->(query) do
    where("company_code LIKE :q OR name LIKE :q", q: "%#{query}%") if query.present?
  end

  validates :name, presence: true
  validates :company_code, presence: true, uniqueness: true
end
