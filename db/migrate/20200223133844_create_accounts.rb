class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :user_code
      t.string :password
      t.string :avatar
      t.references :role, foreign_key: true
      t.references :details_info, foreign_key: true

      t.timestamps
    end
  end
end
