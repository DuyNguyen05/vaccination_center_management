class Account < ApplicationRecord
  # after_create :send_mail_welcome

  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  belongs_to :role, optional: true
  belongs_to :details_info, optional: true
  belongs_to :info_injection_book, optional: true

  has_many :paid_bills, class_name: "Bill", foreign_key: :doctor_id, dependent: :destroy, inverse_of: false
  has_many :doctor_rooms, class_name: "WaitNumber", foreign_key: :doctor_id, dependent: :destroy, inverse_of: false
  has_many :nurse_rooms, class_name: "WaitNumber", foreign_key: :nurse_id, dependent: :destroy, inverse_of: false
  has_many :injection_books, through: :doctor_rooms

  scope :filter_users, ->(query) do
    joins(:details_info).where("email LIKE :q OR user_code LIKE :q OR number_phone LIKE :q", q: "%#{query}%") if query.present?
  end

  scope :filter_info_injection_books, ->(query) do
    joins(:accounts).where("accounts.user_code LIKE :q OR email LIKE :q OR identify_father LIKE :q OR identify_mother LIKE :q OR number_phone LIKE :q", q: "%#{query}%") if query.present?
  end



  class << self

    def all_data_user
      data = []
      day = group_by_day(:created_at).count
      date = day.keys
      user = day.values
      max = 14
      title = "Daily"
      data << {"date" => date, "user" => user, "max" => max, "title" => title}
    end

    def all_data_user1
      data = []
      week = group_by_week(:created_at).count
      date = week.keys
      user = week.values
      max = week.size-1
      title = "Weekly"
      data << {"date" => date, "user" => user, "max" => max, "title" => title}
    end

    def all_data_user2
      data = []
      month = group_by_year(:created_at).count
      date = month.keys
      user = month.values
      max = month.size-1
      title = "Monthly"
      data << {"date" => date, "user" => user, "max" => max, "title" => title}
    end
  end

  def is_current_user? user
    self == user
  end

  def is_staff?
    role.staff?
  end

  def is_admin?
    role.admin?
  end

  def is_super_admin?
    role.super_admin?
  end

  def is_user?
    role.user?
  end

  def is_doctor?
    role.doctor?
  end

  def is_nurse?
    role.nurse?
  end

  def online?
    if current_sign_in_at.present?
      last_sign_out_at.present? ? current_sign_in_at > last_sign_out_at : true
    else
      false
    end
  end

  private

  def send_mail_welcome
    StaffMailer.welcome_email(self, self.user_code, "12345678").deliver_now
  end
end
