class AddDetailInjectionBookToCheckBeforeInjection < ActiveRecord::Migration[5.2]
  def change
    add_column :check_before_injections, :status, :string
    add_reference :check_before_injections, :detail_injection_book, foreign_key: true
  end
end
