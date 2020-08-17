class Province < ApplicationRecord
  has_many :districts
  has_many :addresses

  scope :search_provinces, ->(params) do
    where("name LIKE :q", q: "%#{params}%") if params.present?
  end
end
