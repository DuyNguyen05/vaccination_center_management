class ContractType < ApplicationRecord
  has_many :contracts, dependent: :destroy
end
