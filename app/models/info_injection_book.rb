class InfoInjectionBook < ApplicationRecord
  after_create :create_account

  has_one :account, dependent: :destroy
  has_many :injection_books, dependent: :destroy
  has_many :addresses, dependent: :destroy

  accepts_nested_attributes_for :injection_books
  accepts_nested_attributes_for :addresses

  validates :father_name, length: {minimum: Settings.active_record.info_injection_book.name.minimum, maximum: Settings.active_record.info_injection_book.name.maximum}
  validates :mother_name, length: {minimum: Settings.active_record.info_injection_book.name.minimum, maximum: Settings.active_record.info_injection_book.name.maximum}
  validates :guardian_name, presence: true, length: {minimum: Settings.active_record.info_injection_book.name.minimum, maximum: Settings.active_record.info_injection_book.name.maximum}
  validates :identify_guardian, presence: true, uniqueness: true
  validates :number_phone, presence: true, uniqueness: true
  validates_format_of :email, without: /Settings.active_record.info_injection_book.email.regex/

  scope :newest, -> { order(created_at: :desc) }
  scope :filter_info_injection_books, ->(query) do
    joins(:account).where("accounts.user_code LIKE :q OR identify_father LIKE :q OR identify_mother LIKE :q OR number_phone LIKE :q", q: "%#{query}%") if query.present?
  end

  private

  def create_account
    CreateAccountService.new(info_injection_book_id: self.id).create_account
  end
end
