class CreateContractDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_distributions do |t|
      t.references :contract, foreign_key: true
      t.references :details_info, foreign_key: true
    end
  end
end
