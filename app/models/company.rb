class Company < ApplicationRecord
  # after_create :generate_company_code

  has_many :vaccines
  has_many :orders

  scope :match_query, ->(query) do
    where("company_code LIKE :q OR name LIKE :q", q: "%#{query}%") if query.present?
  end

  validates :name, presence: true


  private

  def generate_company_code
    source = (0..9).to_a
    company_code = ""
    8.times{ company_code += source[rand(source.size)].to_s }
    company = Company.find_by company_code: company_code
    while company.present? do
      company_code = "ORDER-"
      8.times{ company_code += source[rand(source.size)].to_s }
      company = Company.find_by company_code: company_code
    end
    company_code
    self.company_code = company_code
    self.save!
  end
end
