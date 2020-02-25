class CreateVaccineDistribution < ActiveRecord::Migration[5.2]
  def change
    create_table :vaccine_distributions do |t|
      t.references :vaccine, foreign_key: true
      t.references :vaccination_center, foreign_key: true
    end
  end
end
