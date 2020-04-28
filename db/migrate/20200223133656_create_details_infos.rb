class CreateDetailsInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :details_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :identify
      t.string :number_phone
      t.string :permanent_address
      t.string :current_address
      t.string :bank
      t.string :bank_account_number
      t.string :language
      t.string :certificate
      t.string :experience
      t.string :nationality
      t.string :gender
      t.string :tax_code
      t.references :vaccination_center, foreign_key: true
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
