class CreateDetailBills < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_bills do |t|
      t.references :vaccine, foreign_key: true
      t.references :vaccine_package_type, foreign_key: true
      t.integer :number_injection
      t.string :unit_price
      t.string :discount
      t.string :amount

      t.timestamps
    end
  end
end
