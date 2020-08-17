class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :info_injection_book, foreign_key: true
      t.integer :province_id
      t.integer :district_id
      t.integer :ward_id
      t.string :current_address
      t.string :permanent_address
      t.string :hometown

      t.timestamps
    end
  end
end
