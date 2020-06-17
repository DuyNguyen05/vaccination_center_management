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

  def amount a, b
    number_with_delimiter(a*(b.to_f))
  end

  def total_price a
    number_to_currency(a)
  end

  def set_checked_for_checkbox answer_question
    answer_question == "true" ? "CÓ" : "KHÔNG"
  end
end
