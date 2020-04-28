class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.datetime :creation_time
      t.datetime :payment_time
      t.references :account, foreign_key: true
      t.references :injection_book, foreign_key: true
      t.string :total_money
      t.string :code
      t.references :detail_bill, foreign_key: true

      t.timestamps
    end
  end
end
