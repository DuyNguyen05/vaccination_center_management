class District < ApplicationRecord
  belongs_to :province
  has_many :wards

  scope :search_districts, ->(params) do
    where("name LIKE :q", q: "%#{params}%") if params.present?
  end
end
