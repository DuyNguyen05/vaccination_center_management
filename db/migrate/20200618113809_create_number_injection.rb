class CreateNumberInjection < ActiveRecord::Migration[5.2]
  def change
    create_table :number_injections do |t|
      t.integer :min_age
      t.integer :max_age
      t.string :name
      t.references :vaccine, foreign_key: true

      t.timestamps
    end
  end
end
