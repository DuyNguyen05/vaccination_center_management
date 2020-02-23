class CreateInjectionBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :injection_books do |t|
      t.string :book_code
      t.string :name_person_injected
      t.datetime :date_of_birth
      t.string :place_of_birth
      t.references :info_injection_book, foreign_key: true
    end
  end
end
