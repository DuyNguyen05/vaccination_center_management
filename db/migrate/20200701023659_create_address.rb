class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :info_injection_book, foreign_key: true
      t.string :province
      t.string :district
      t.string :ward
      t.string :current_address
      t.string :permanent_address
      t.string :hometown

      t.timestamps
    end
  end
end
