class ImportVaccine < ApplicationRecord
  belongs_to :vaccine
  belongs_to :account
  belongs_to :company, class_name: Company.name, foreign_key: :company_code
end
