class CreateDetailInjectionBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_injection_books do |t|
      t.datetime :injection_date
      t.string :react_after_injection
      t.datetime :time_after_injection
      t.references :vaccination_center, foreign_key: true
      t.references :account, foreign_key: true
      t.references :injection_book, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
