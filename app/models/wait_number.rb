class WaitNumber < ApplicationRecord
  belongs_to :doctor, class_name: "Account"
  belongs_to :nurse, class_name: "Account", optional: true
  belongs_to :injection_book

  validates :injection_book_id, presence: true, uniqueness: true
end
