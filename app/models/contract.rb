class Contract < ApplicationRecord
  belongs_to :contract_type
  has_many :contract_distributions, dependent: :destroy
end
