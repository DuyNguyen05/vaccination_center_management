class AddColumnToVaccines < ActiveRecord::Migration[5.2]
  def change
    add_column :vaccines, :quantity, :integer
    add_reference :vaccines, :account, foreign_key: true
    add_reference :vaccines, :company, foreign_key: true
  end
end
