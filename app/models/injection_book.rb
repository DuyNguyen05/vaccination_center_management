class InjectionBook < ApplicationRecord
  after_create :generate_book_code

  belongs_to :info_injection_book
  has_many :detail_injection_books, dependent: :destroy
  has_many :register_injection_packages, dependent: :destroy
  has_many :vaccine_package_types, through: :register_injection_packages, dependent: :destroy

  validates_presence_of :info_injection_book

  enum gender: [:male, :female]

  scope :newest, -> {order id: :desc}
  scope :filter_injection_books, ->(query) do
    where("book_code LIKE :q OR name_person_injected LIKE :q OR date_of_birth LIKE :q", q: "%#{query}%") if query.present?
  end

  private

  def generate_book_code
    source = (0..9).to_a
    book_code = "INB"
    5.times{ book_code += source[rand(source.size)].to_s }
    self.book_code = book_code
    self.save!
  end
end
