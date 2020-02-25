class CreateDetailBills < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_bills do |t|
      t.references :vaccine, foreign_key: true
      t.references :vaccine_package, foreign_key: true
      t.string :unit_price
      t.string :amount
    end
  end
end
