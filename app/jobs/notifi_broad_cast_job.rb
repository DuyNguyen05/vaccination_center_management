class NotifiBroadcastJob < ApplicationJob
  # queue_as :default

  def perform(id)
  	appointment = Appointment.find(id)
  	injection_book = InjectionBook.find_by(book_code: appointment.book_code)
    account_id = injection_book.info_injection_book.account.id
    vaccine_id = appointment.vaccine_id
    notification = Notifi.create(account_id: account_id, vaccine_id: vaccine_id, 
    	injection_book_id: injection_book.id)

    NotificationService.new(notification).excute
  end
end