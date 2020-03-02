class ContractDistribution < ApplicationRecord
  belongs_to :contract
  belongs_to :detail_info
end
