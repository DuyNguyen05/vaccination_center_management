class DetailsInfo < ApplicationRecord
  # after_create :create_account

  belongs_to :vaccination_center, optional: true
  belongs_to :department, optional: true

  has_one :account, dependent: :destroy

  validates :first_name, length: {minimum: Settings.active_record.details_info.name.minimum, maximum: Settings.active_record.details_info.name.maximum}
  validates :last_name, length: {minimum: Settings.active_record.details_info.name.minimum, maximum: Settings.active_record.details_info.name.maximum}
  validates :number_phone, presence: true, uniqueness: true,
    length: {minimum: Settings.active_record.details_info.number_phone.minimum, maximum: Settings.active_record.details_info.number_phone.maximum}
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, without: /Settings.active_record.details_info.email.regex/
  validates :identify, presence: true, uniqueness: true

  # def create_account(role)
  #   byebug
  #   CreateAccountService.new(details_info_id: self.id).create_account(role)
  # end
end
