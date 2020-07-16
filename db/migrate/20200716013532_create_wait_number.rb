class CreateWaitNumber < ActiveRecord::Migration[5.2]
  def change
    create_table :wait_numbers do |t|
      t.integer :doctor_id
      t.integer :nurse_id
      t.references :injection_book, foreign_key: true
      t.boolean :appointment, default: false
      t.integer :number
      t.string :room
      t.references :detail_bill, foreign_key: true

      t.timestamps
    end
  end
end
