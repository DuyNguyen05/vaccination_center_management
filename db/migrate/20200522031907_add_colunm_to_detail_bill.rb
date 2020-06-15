class AddColunmToDetailBill < ActiveRecord::Migration[5.2]
  def change
    add_reference :detail_bills, :register_injection_package, foreign_key: true, index: true
    add_reference :detail_bills, :bill, foreign_key: true, index: true
  end
end
