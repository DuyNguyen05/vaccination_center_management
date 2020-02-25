class AddVaccinePackageTypeToVaccinePackages < ActiveRecord::Migration[5.2]
  def change
    add_reference :vaccine_packages, :vaccine_package_type, foreign_key: true, type: :integer
    add_reference :vaccine_packages, :detail_vaccine_package, foreign_key: true
  end
end
