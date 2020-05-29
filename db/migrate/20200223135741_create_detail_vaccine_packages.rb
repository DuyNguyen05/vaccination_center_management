class CreateDetailVaccinePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_vaccine_packages do |t|
      t.references :vaccine_package_type, foreign_key: true
      t.references :vaccine, foreign_key: true
      t.integer :total_injections
      t.string :user_code

      t.timestamps
    end
  end
end
