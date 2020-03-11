class AddColumnToInjectionBook < ActiveRecord::Migration[5.2]
  def change
    add_column :injection_books, :gender, :integer, default: "0"
    add_column :info_injection_books, :email, :string
  end
end
