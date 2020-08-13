class CreateDetailOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_orders do |t|
      t.string :quantity
      t.references :order
      t.references :vaccine

      t.timestamps
    end
  end
end
