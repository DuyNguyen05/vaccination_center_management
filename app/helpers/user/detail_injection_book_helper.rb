module User::DetailInjectionBookHelper
  def set_active_for_step current_step, params_step
    'active' if current_step >= params_step
  end

  def vaccination_center
    VaccinationCenter.last
  end

  def detail_bill(detail_injection_book)
    detail_injection_book.bill.detail_bills
  end

  def number_injections detail_injection_book
    number_injection = 0
    detail_injection_book.bill.detail_bills.each do |detail_bill|
      number_injection = number_injection + detail_bill.number_injection
    end
    return number_injection
  end

  def amount detail_injection_book
    amount = 0
    detail_injection_book.bill.detail_bills.each do |detail_bill|
      amount = amount + (detail_bill.number_injection)*(detail_bill.vaccine.saleprice.to_i*1000)
    end
    return number_with_delimiter(amount)
  end

  def total_price detail_injection_book
    amount = amount detail_injection_book
    number_to_currency(number_with_delimiter(amount))
  end

  def set_checked_for_checkbox answer_question
    return "" if answer_question.blank?
    answer_question == "true" ? "CÓ" : "KHÔNG"
  end
end
