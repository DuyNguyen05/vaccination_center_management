class AddColumnsToVaccines < ActiveRecord::Migration[5.2]
  def change
    add_column :vaccines, :quantity, :integer
    add_column :vaccines, :company_code, :string
    add_column :vaccines, :user_code, :string

    add_index :vaccines, :user_code, unique: true
    add_index :vaccines, :company_code, unique: true
    add_reference :vaccines, :admin, foreign_key: true
    add_reference :vaccines, :company, foreign_key: true
  end
end
