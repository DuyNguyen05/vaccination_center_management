class AddReferenceToAccount < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :info_injection_book, foreign_key: true
  end
end
