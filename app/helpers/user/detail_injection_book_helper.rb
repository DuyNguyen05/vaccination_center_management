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
    a*(b.to_i)
  end
end
