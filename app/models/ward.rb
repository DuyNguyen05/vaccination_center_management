class Ward < ApplicationRecord
  belongs_to :district

  scope :search_wards, ->(params) do
    where("name LIKE :q", q: "%#{params}%") if params.present?
  end
end
