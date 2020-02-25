class CreateImportVaccines < ActiveRecord::Migration[5.2]
  def change
    create_table :import_vaccines do |t|
      t.string :company_code
      t.integer :quantity
      t.references :vaccine, foreign_key: true
      t.references :account, foreign_key: true
      t.datetime :created_at
    end
  end
end
