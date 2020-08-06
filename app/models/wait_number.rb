class WaitNumber < ApplicationRecord
  belongs_to :doctor, class_name: "Account"
  belongs_to :nurse, class_name: "Account", optional: true
  belongs_to :injection_book

  validates :injection_book_id, presence: true, uniqueness: true
  validate :format_injection_book, if: :injection_book_id

  def format_injection_book
  	injection_book = InjectionBook.find(injection_book_id)
  	status_injection_book = injection_book.detail_injection_books.last
    return unless status_injection_book.present?
  	unless (status_injection_book.status == "step_5" || status_injection_book.status == "cancel")
  		errors.add(:injection_book_id, I18n.t("errors.messages.injection_boook_exist"))
  	end
  end
end
