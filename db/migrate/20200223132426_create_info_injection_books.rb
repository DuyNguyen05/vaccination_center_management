class CreateInfoInjectionBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :info_injection_books do |t|
      t.string :father_name
      t.string :identify_father
      t.string :year_of_birth_father
      t.string :mother_name
      t.string :identify_mother
      t.string :year_of_birth_mother
      t.string :guardian_name
      t.string :identify_guardian
      t.string :year_of_birth_guardian
      t.string :number_phone
      t.string :current_address
      t.string :permanent_address
      # t.string :detail_current_address
      # t.string :detail_permanent_address
      t.boolean :check_info, default: true

      t.timestamps
    end
  end
end
