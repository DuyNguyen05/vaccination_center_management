class CreateVaccines < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccines do |t|
      t.string :code
      t.string :name
      t.string :manufacture
      t.datetime :expiry_date
      t.text :content, limit: 4294967295
      t.references :vaccine_type, foreign_key: true
      t.string :unit
      t.string :dosage
      t.string :entry_price


      t.timestamps
    end
  end
end
