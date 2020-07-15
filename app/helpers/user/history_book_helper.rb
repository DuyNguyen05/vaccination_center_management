module User::HistoryBookHelper
  def vaccines_injected injection_book
    detail_bills = DetailBill.where(bill_id: injection_book.bills.ids)
    vaccines = Vaccine.find(detail_bills.map(&:vaccine_id).uniq)
  end

  def history_injected injection_book, vaccine
     history_injected = DetailBill.where(bill_id: injection_book.bills.ids).where(vaccine_id: vaccine.id).to_a
  end
end
