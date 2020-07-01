class CreateWard < ActiveRecord::Migration[5.2]
  def change
    create_table :wards do |t|
      t.string :name
      t.references :district, foreign_key: true
    end
  end
end
