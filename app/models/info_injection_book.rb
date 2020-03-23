class InfoInjectionBook < ApplicationRecord
  after_create :create_account

  has_many :injection_books, inverse_of: :info_injection_book
  accepts_nested_attributes_for :injection_books

  has_one :account, dependent: :destroy

  validates :father_name, length: {minimum: Settings.active_record.info_injection_book.name.minimum, maximum: Settings.active_record.info_injection_book.name.maximum}
  validates :mother_name, length: {minimum: Settings.active_record.info_injection_book.name.minimum, maximum: Settings.active_record.info_injection_book.name.maximum}
  validates :number_phone, presence: true, uniqueness: true
  validates :email, uniqueness: true

  private

  def create_account
    CreateAccountService.new(info_injection_book_id: self.id).create_account
  end
end
