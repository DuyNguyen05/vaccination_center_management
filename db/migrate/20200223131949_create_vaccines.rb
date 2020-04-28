class CreateVaccines < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccines do |t|
      t.string :code
      t.string :name
      t.string :manufacture
      t.datetime :date_of_application
      t.string :expiry_date
      t.string :content
      t.string :date_added
      t.string :inventory
      t.references :vaccine_type, foreign_key: true

      t.timestamps
    end
  end
end
