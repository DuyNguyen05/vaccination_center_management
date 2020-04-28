class CreateVaccineTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccine_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
