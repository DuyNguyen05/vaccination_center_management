class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.datetime :start_at
      t.datetime :finish_at
      t.integer :expire
      t.references :contract_type, foreign_key: true
    end
  end
end
