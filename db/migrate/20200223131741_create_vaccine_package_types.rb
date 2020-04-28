class CreateVaccinePackageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccine_package_types, id: :integer do |t|
      t.string :name

      t.timestamps
    end
  end
end
