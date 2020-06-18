class Vaccine < ApplicationRecord
  belongs_to :vaccine_type, optional: true
  has_many :detail_injection_books
  has_many :injection_books, through: :detail_injection_books
  belongs_to :company, class_name: Company.name, foreign_key: :company_code
  has_many :detail_vaccine_packages, dependent: :destroy
  has_many :vaccine_package_types, through: :detail_vaccine_packages, dependent: :destroy
  has_many :number_injections, dependent: :destroy

  enum tag: {default: "default", other: "other"}

  scope :newest, -> { order(created_at: :desc) }
  scope :match_query, ->(query) do
    where("code LIKE :q OR manufacture LIKE :q", q: "%#{query}%") if query.present?
  end
  scope :search_vaccines, ->(params) do
    where("code LIKE :q OR name LIKE :q", q: "%#{params}%") if params.present?
  end

  validates :code, presence: true, uniqueness: true
  validates :manufacture, presence: true
  validates :content, presence: true
  validates :expiry_date, presence: true
  validates :quantity, presence: true
  validates :company_code, presence: true

end
