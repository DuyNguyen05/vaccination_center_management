class AddColumnToBill < ActiveRecord::Migration[5.2]
  def change
    add_reference :bills, :detail_injection_book, foreign_key: true, index: true
  end
end
