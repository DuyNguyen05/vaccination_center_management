class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :company, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
