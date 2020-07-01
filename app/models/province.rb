class Province < ApplicationRecord
  has_many :districts

  scope :search_provinces, ->(params) do
    where("name LIKE :q", q: "%#{params}%") if params.present?
  end
end
