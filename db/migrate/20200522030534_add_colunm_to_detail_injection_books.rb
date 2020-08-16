class AddColunmToDetailInjectionBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :detail_injection_books, :check_before_injection, foreign_key: true, index: true
  end
end
