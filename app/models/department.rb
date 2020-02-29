class Department < ApplicationRecord
  has_many :details_infors, dependent: :destroy
end
