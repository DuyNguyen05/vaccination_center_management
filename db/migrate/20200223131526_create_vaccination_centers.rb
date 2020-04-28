class CreateVaccinationCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccination_centers do |t|
      t.string :code
      t.string :address
      t.string :number_phone

      t.timestamps
    end
  end
end
