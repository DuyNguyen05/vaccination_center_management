class CreateVaccinePackageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccine_package_types do |t|
      t.string :name
      t.string :content
      t.string :code

      t.timestamps
    end
  end
end
