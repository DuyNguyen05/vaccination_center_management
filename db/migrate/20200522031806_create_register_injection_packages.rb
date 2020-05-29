class CreateRegisterInjectionPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :register_injection_packages do |t|
      t.references :injection_book, foreign_key: true
      t.references :vaccine_package_type, foreign_key: true
      t.references :bill, foreign_key: true

      t.timestamps
    end
  end
end
