class AddAvatarToInjectionBook < ActiveRecord::Migration[5.2]
  def change
    add_column :injection_books, :avatar, :string
  end
end
