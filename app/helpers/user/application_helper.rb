module User::ApplicationHelper
  def check_online account
    return account.online? ? "primary" :  "secondary"
  end

  def check_button account
    return account.online? ? "visible" :  "invisible"
  end

  def wait_injection_books doctor_rooms
    InjectionBook.find(doctor_rooms.map(&:injection_book_id))
  end
end
