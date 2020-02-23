class CreateVaccinePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccine_packages do |t|
      t.string :name
      t.string :content
      t.string :code
      t.string :total_injections
      t.string :price
      t.references :vaccine_package_type, foreign_key: true
      t.references :detail_vaccine_package, foreign_key: true
    end
  end
end
