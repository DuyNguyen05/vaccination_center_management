class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :company_code
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
