class CreateDetailOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_orders do |t|
      t.string :vaccine_id
      t.string :quantity
      t.references :order

      t.timestamps
    end
  end
end
