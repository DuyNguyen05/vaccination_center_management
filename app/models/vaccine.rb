class Vaccine < ApplicationRecord
  extend Enumerize

  # after_create :generate_vaccine_code

  # belongs_to :vaccine_type, optional: true
  belongs_to :company, class_name: Company.name, foreign_key: :company_code
  has_many :detail_injection_books
  has_many :injection_books, through: :detail_injection_books
  has_many :detail_vaccine_packages, dependent: :destroy
  has_many :vaccine_package_types, through: :detail_vaccine_packages, dependent: :destroy
  has_many :number_injections, dependent: :destroy
  has_many :detail_bills, dependent: :destroy
  has_many :bills, through: :detail_bills
  has_many :detail_orders, dependent: :destroy

  enumerize :tag, in: [:default, :other], default: :default

  scope :newest, -> { order(created_at: :desc) }

  scope :match_query, ->(query) do
    where("code LIKE :q OR manufacture LIKE :q OR name LIKE :q", q: "%#{query}%") if query.present?
  end
  scope :search_vaccines, ->(params) do
    where("code LIKE :q OR name LIKE :q", q: "%#{params}%") if params.present?
  end

  # validates :code, presence: true, uniqueness: true
  validates :manufacture, presence: true
  # validates :content, presence: true
  validates :expiry_date, presence: true
  validates :quantity, presence: true
  validates :company_code, presence: true

  enum tag: {default: "default", other: "other"}

  scope :newest, -> { order(created_at: :desc) }

  class << self
    def all_data_product
      data = []
      day = group_by_day(:created_at).count
      date = day.keys
      product = day.values
      data << {"date" => date, "product" => product}
    end

    def all_data_product1
      data = []
      week = group_by_week(:created_at).count
      date = week.keys
      product = week.values
      data << {"date" => date, "product" => product}
    end

    def all_data_product2
      data = []
      month = group_by_year(:created_at).count
      date = month.keys
      product = month.values
      data << {"date" => date, "product" => product}
    end
  end

  private

  def generate_vaccine_code
    source = (0..9).to_a
    vaccine_code = ""
    8.times{ vaccine_code += source[rand(source.size)].to_s }
    vaccine = Vaccine.find_by code: vaccine_code
    while vaccine.present? do
      vaccine_code = ""
      8.times{ vaccine_code += source[rand(source.size)].to_s }
      vaccine = Vaccine.find_by code: vaccine_code
    end
    vaccine_code
    self.code = vaccine_code
    self.save!
  end
end
