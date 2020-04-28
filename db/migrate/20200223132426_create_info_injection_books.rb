class CreateInfoInjectionBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :info_injection_books do |t|
      t.string :father_name
      t.string :identify_father
      t.string :mother_name
      t.string :identify_mother
      t.string :number_phone
      t.string :current_address
      t.string :permanent_address

      t.timestamps
    end
  end
end
